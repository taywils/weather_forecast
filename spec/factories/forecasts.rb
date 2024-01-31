# frozen_string_literal: true

# == Schema Information
#
# Table name: forecasts
#
#  id                  :bigint           not null, primary key
#  address             :string(100)
#  average_temperature :integer
#  highest_temperature :integer
#  lowest_temperature  :integer
#  zip_code            :string(10)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :forecast do
    address { Faker::Address.full_address }
    average_temperature { rand(-20..120) }
    lowest_temperature { rand(-20..120) }
    highest_temperature { rand(-20..120) }
    zip_code { Faker::Address.zip_code }
  end
end
