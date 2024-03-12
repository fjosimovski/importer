# frozen_string_literal: true

# app/jobs/import_employees_job.rb

class ImportEmployeesJob
  include Sidekiq::Worker

  def perform(access_token)
    employees_data = ApiServices::ImportService.get_employees(access_token)

    employees_data.each do |employee_data|
      save_employee(employee_data)
    end
  end

  private

  def save_employee(employee_data)
    employee_attributes = {
      date_of_birth: employee_data['date_of_birth'],
      email: employee_data['email'],
      first_name: employee_data['first_name'],
      last_name: employee_data['last_name'],
      address: employee_data['address'],
      country: employee_data['country'],
      bio: employee_data['bio'],
      rating: employee_data['rating'],
      external_id: employee_data['id']
    }

    # Update or Create employee with employee_attributes
    Employee.find_or_initialize_by(external_id: employee_attributes[:external_id]).update(employee_attributes)
  end
end
