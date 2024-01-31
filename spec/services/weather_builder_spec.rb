# frozen_string_literal: true

require 'rails_helper'

describe WeatherBuilder do
  describe '.call' do
    context 'when the forecast_hashes are valid' do
      subject(:context) { described_class.call(forecast_hashes:) }

      let(:forecast_hashes) do
        JSON.parse(fixture('weather_parser_output.json').read)
      end

      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'when the forecast_hashes are invalid' do
      subject(:context) { described_class.call(forecast_hashes:) }

      let(:forecast_hashes) { nil }

      it 'fails' do
        expect(context).to be_failure
      end

      it 'provides an error message' do
        expect(context.error).not_to be_empty
      end
    end
  end
end
