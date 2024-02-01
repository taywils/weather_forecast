# frozen_string_literal: true

# The WeatherOrganizer class is responsible for organizing the workflow of fetching, parsing, and building weather data.
class WeatherOrganizer
  include Interactor::Organizer

  # The organize method defines the interactors that make up this organizer.
  # The interactors are run in the order they are listed.
  # The `context` of each interactor is passed to the next interactor in the chain.
  organize WeatherFetcher, WeatherParser, WeatherBuilder
end
