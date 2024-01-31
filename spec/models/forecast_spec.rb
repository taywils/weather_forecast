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
end
