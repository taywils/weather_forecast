# frozen_string_literal: true

class WeatherParser
  include Interactor

  def call
    context.data = JSON.parse(context.raw_json_body, symbolize_names: true)

    extract_address
    extract_zip_code
    extract_forecast_hashes
  rescue StandardError => e
    context.fail!(error: e.message)
  end

  private

  def extract_address
    context.address = context.data.dig(:location, :name).strip

    raise StandardError, 'Invalid Address' if context.address.blank?
  end

  def extract_zip_code
    context.zip_code = context.address.split(',').fetch(2, nil).strip

    raise StandardError, 'Invalid Zipcode' if context.zip_code.blank?
  end

  def extract_forecast_hashes
    context.data.dig(:timelines, :daily).each do |daily_value|
      forecast_hash = build_forecast_hash(daily_value)

      raise StandardError, 'Forecast values cannot be nil' if forecast_hash.values.any?(&:nil?)

      context.forecast_hashes ||= []
      context.forecast_hashes << forecast_hash
    end
  end

  def build_forecast_hash(daily_value)
    {
      address: context.address,
      average_temperature: daily_value.dig(:values, :temperatureApparentAvg).round,
      highest_temperature: daily_value.dig(:values, :temperatureApparentMax).round,
      lowest_temperature: daily_value.dig(:values, :temperatureApparentMin).round,
      date: daily_value[:time].to_date,
      zip_code: context.zip_code
    }
  end
end
