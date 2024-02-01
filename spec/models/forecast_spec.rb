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
require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:address) }

    it { is_expected.to validate_presence_of(:date) }

    it { is_expected.to validate_presence_of(:average_temperature) }
    it { is_expected.to validate_numericality_of(:average_temperature).only_integer }

    it { is_expected.to validate_presence_of(:highest_temperature) }
    it { is_expected.to validate_numericality_of(:highest_temperature).only_integer }

    it { is_expected.to validate_presence_of(:lowest_temperature) }
    it { is_expected.to validate_numericality_of(:lowest_temperature).only_integer }

    it { is_expected.to validate_presence_of(:zip_code) }
  end

  describe 'scopes' do
    describe '.recent' do
      it 'orders by date in descending order' do
        oldest_forecast = create(:forecast, date: 1.day.ago)
        newest_forecast = create(:forecast, date: 1.day.from_now)

        expect(described_class.recent).to eq([newest_forecast, oldest_forecast])
      end
    end
  end

  describe '#display_name' do
    it 'returns the city, state, zip code, and short date' do
      forecast = build(:forecast,
                       address: 'Seattle, King County, 98121, Washington, United States',
                       date: '2024-01-30',
                       zip_code: '98121')
      expect(forecast.display_name).to eq('Seattle, Washington 98121 @ Jan 30 2024')
    end
  end

  describe '#display_short_date' do
    it 'returns the date in the format of "Mon DD YYYY"' do
      forecast = build(:forecast, date: '2024-01-30')

      expect(forecast.display_short_date).to eq('Jan 30 2024')
    end
  end
end
