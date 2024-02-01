# frozen_string_literal: true

class WeatherOrganizer
  include Interactor::Organizer

  organize WeatherFetcher, WeatherParser, WeatherBuilder
end
