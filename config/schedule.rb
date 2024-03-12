# frozen_string_literal: true

# config/schedule.rb

every 15.minutes do
  runner 'ImportEmployeesJob.perform_async(ApiServices::ImportService.authenticate)'
end
