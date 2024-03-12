# frozen_string_literal: true

class Employee < ApplicationRecord
  validates :date_of_birth, :email, :first_name, :last_name, :address, :country, :bio, :rating, :external_id,
            presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
