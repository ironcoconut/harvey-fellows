class ProcessContributions
  include SuckerPunch::Job

  def perform(fellow_id: fellow_id)
    fellow = Fellow.includes(:contributions).find(fellow_id)

    fellow.contributions.each do |contribution|
      next if contribution.charge_id.present?

      # TODO handle the errors this will generate if something goes wrong
      result = Stripe::Charge.create(
        amount: (contribution.amount * 100).to_i,
        currency: "usd",
        customer: contribution.customer_id
      )

      Contribution.update(charge_id: result.id)

      # TODO send email for contribution
    end
  end
end
