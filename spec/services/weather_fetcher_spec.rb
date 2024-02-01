# frozen_string_literal: true

require 'rails_helper'

describe WeatherFetcher do
  describe '.call' do
    context 'when the zip_code is invalid' do
      subject(:context) { described_class.call(zip_code: '00000') }

      it 'fails' do
        expect(context).to be_failure
      end
    end

    context 'when the zip_code is valid' do
      subject(:context) { described_class.call(zip_code: '98121', api_conn:) }

      let(:stubs) { Faraday::Adapter::Test::Stubs.new }
      let(:api_conn) { Faraday.new { |b| b.adapter(:test, stubs) } }
      let(:response_body) { { hello: 'world' }.to_json }

      it 'succeeds' do
        stubs.get('/v4/weather/forecast') { [200, {}, response_body] }
        expect(context).to be_success
      end

      it 'the raw_json_body is not nil' do
        stubs.get('/v4/weather/forecast') { [200, {}, response_body] }
        expect(context.raw_json_body).to eq(response_body)
      end
    end
  end
end
