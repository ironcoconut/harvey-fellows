namespace :github do
  desc "Update fellows github informatoin"
  task update_fellows: :environment do
    UpdateFellows.perform_async
  end
end
