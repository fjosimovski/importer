# frozen_string_literal: true

# lib/tasks/import_data.rake
namespace :import do
  desc 'Import data on setup'
  task setup: :environment do
    access_token = ApiServices::ImportService.authenticate
    ImportEmployeesJob.perform_async(access_token)
  end
end
