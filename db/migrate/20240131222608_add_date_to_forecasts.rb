# frozen_string_literal: true

class AddDateToForecasts < ActiveRecord::Migration[7.1]
  def change
    add_column :forecasts, :date, :date
  end
end
