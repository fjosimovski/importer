# frozen_string_literal: true

# spec/models/employee_spec.rb
require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    context 'when creating a new employee' do
      let(:valid_employee) { build(:employee) }
      let(:invalid_employee) { build(:employee, email: 'invalid_email') }

      it 'is valid with valid attributes' do
        expect(valid_employee).to be_valid
      end

      %i[date_of_birth email first_name last_name address country bio rating external_id].each do |attribute|
        it "validates presence of #{attribute}" do
          valid_employee[attribute] = nil
          expect(valid_employee).not_to be_valid
          expect(valid_employee.errors[attribute]).to include("can't be blank")
        end
      end

      it 'validates email format' do
        invalid_employee.valid?
        expect(invalid_employee.errors[:email]).to include('is invalid')
      end
    end
  end
end
