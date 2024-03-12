# frozen_string_literal: true

# spec/factories/employees.rb
FactoryBot.define do
  factory :employee do
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    address { Faker::Address.street_address }
    country { Faker::Address.country }
    bio { Faker::Lorem.paragraph }
    rating { Faker::Number.between(from: 0, to: 1.0).round(2) }
    external_id { Faker::Number.between(from: 0, to: 9999) }
  end
end
