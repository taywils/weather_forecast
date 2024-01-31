# frozen_string_literal: true

require 'rails_helper'

describe WeatherParser do
  describe '.call' do
    context 'when the raw_json_body is invalid' do
      subject(:context) { described_class.call(raw_json_body: dummy_json) }

      let(:dummy_json) { { 'key' => 'value' }.to_json }

      it 'fails' do
        expect(context).to be_failure
      end

      it 'provides an error message' do
        expect(context.error).not_to be_empty
      end
    end

    context 'when the raw_json_body is valid' do
      subject(:context) { described_class.call(raw_json_body: tomorrow_raw_json) }

      let(:tomorrow_raw_json) { fixture('tomorrow_io_response.json').read }
      let(:context_address) { 'Seattle, King County, 98121, Washington, United States' }
      let(:context_zip_code) { '98121' }

      it 'succeeds' do
        expect(context).to be_success
      end

      it 'the data is not nil' do
        expect(context.data).not_to be_nil
      end

      it 'sets the context address' do
        expect(context.address).to eq(context_address)
      end

      it 'sets the context zip_code' do
        expect(context.zip_code).to eq(context_zip_code)
      end

      it 'sets the forecast_hashes' do
        expect(context.forecast_hashes).not_to be_empty
      end
    end
  end
end
