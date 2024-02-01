# frozen_string_literal: true

class WeatherFetcher
  include Interactor

  before do
    context.fail!(error: 'Invalid Zipcode') if context.zip_code.blank? || ZipCodes.identify(context.zip_code).blank?
  end

  def call
    initialize_api
    api_fetch

    raise StandardError if context.raw_json_body.blank?
  rescue StandardError => e
    context.fail!(error: e.message)
  end

  private

  def initialize_api
    context.api_conn ||= Faraday.new(
      url: 'https://api.tomorrow.io',
      params: {
        apikey: Rails.application.credentials.dig(:api_keys, :tomorrow_io),
        units: 'imperial',
        timesteps: '1d'
      },
      headers: { 'Content-Type' => 'application/json' }
    )
  end

  def api_fetch
    begin
      response = context.api_conn.get('/v4/weather/forecast') do |request|
        request.params['location'] = "#{context.zip_code} US"
      end
    rescue Faraday::Error => e
      context.fail!(error: e.message)
    end

    context.raw_json_body = response.body
  end
end
