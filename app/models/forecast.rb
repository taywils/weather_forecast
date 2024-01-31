# frozen_string_literal: true

# == Schema Information
#
# Table name: forecasts
#
#  id                  :bigint           not null, primary key
#  address             :string(100)
#  average_temperature :integer
#  date                :date
#  highest_temperature :integer
#  lowest_temperature  :integer
#  zip_code            :string(10)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Forecast < ApplicationRecord
  validates :address, presence: true
  validates :date, presence: true
  validates :average_temperature, presence: true, numericality: { only_integer: true }
  validates :highest_temperature, presence: true, numericality: { only_integer: true }
  validates :lowest_temperature, presence: true, numericality: { only_integer: true }
  validates :zip_code, presence: true
end
