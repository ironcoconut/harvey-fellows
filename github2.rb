namespace :github do
  desc "Update fellows github information"
  task :update_fellows => :environment do
    UpdateFellows.perform_async
  end
end
