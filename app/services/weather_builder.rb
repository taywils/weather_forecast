# frozen_string_literal: true

# The WeatherBuilder class is responsible for building the weather data object
# from the parsed data. It is part of the WeatherOrganizer interactor chain.
class WeatherBuilder
  include Interactor

  def call
    result = Forecast.create!(context.forecast_hashes)

    raise StandardError, 'Invalid Forecast' if result.blank? || result.nil?
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(error: e.message)
  rescue StandardError => e
    context.fail!(error: e.message)
  end
end
