# frozen_string_literal: true

class EmployeesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @employees = pagy(Employee.all, items: 10)
  end
end
