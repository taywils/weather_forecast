# frozen_string_literal: true

json.array! @forecasts, partial: 'forecasts/forecast', as: :forecast
