# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.date :date_of_birth
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :country
      t.text :bio
      t.float :rating
      t.string :external_id

      t.timestamps
    end
  end
end
