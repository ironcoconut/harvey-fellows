class UpdateFellows
  include SuckerPunch::Job

  def perform
    Fellow.all.find_each do |fellow|
      user = github.users.get user: fellow.login

      fellow.name = user.name
      fellow.avatar_url = user.avatar_url
      fellow.bio = user.bio
      fellow.html_url = user.html_url

      fellow.save
    end

    Rails.logger.info "Updated fellows complete"
  end

  def github
    @github ||= Github.new
  end
end
