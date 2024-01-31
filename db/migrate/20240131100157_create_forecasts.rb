# frozen_string_literal: true

class CreateForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :forecasts do |t|
      t.string :address, limit: 100
      t.integer :average_temperature
      t.integer :lowest_temperature
      t.integer :highest_temperature
      t.string :zip_code, limit: 10

      t.timestamps
    end
  end
end
