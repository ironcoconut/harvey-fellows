class ContributionsController < ApplicationController
  def create
    # create customer. store customer id on transaction only.
    customer

    contribution = Contribution.create(user: user, fellow: fellow, amount: amount, customer_id: customer.id)

    if(fellow.total_goal <= total_raised)
      ProcessContributions.perform_async(fellow_id: fellow.id)
      msg = "Congratulations! We have met the goal for fellow #{@fellow.name}"
    else
      msg = "Thank you for your contribution."
    end

    redirect_to @fellow, notice: msg
  end

  private

  def customer
    @customer ||= Stripe::Customer.create(
      :email => email,
      :source => token,
    )
  end

  def amount
    @amount ||= params[:contribution][:amount].to_i > 0 ? params[:contribution][:amount].to_i : nil
  end

  def email
    @email ||= params[:contribution][:email].present? ? params[:contribution][:email] : nil
  end

  def token
    @token ||= params[:stripeToken]
  end

  def fellow
    @fellow ||= Fellow.find(params[:contribution][:fellow_id])
  end

  def user
    if(email)
      # TODO Invite users to system to view stuff, etc
      @user ||= User.where(email: email).first_or_create(password: new_password)
    else
      nil
    end
  end

  def new_password
    params[:contribution][:password].present? ? params[:contribution][:password] : SecureRandom.urlsafe_base64
  end

  def total_raised
    Contribution.where(fellow_id: fellow.id).sum(:amount)
  end
end
