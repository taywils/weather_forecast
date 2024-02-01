# frozen_string_literal: true

Forecast.destroy_all

[
  {
    "address": 'Seattle, King County, 98121, Washington, United States',
    "average_temperature": 53,
    "highest_temperature": 55,
    "lowest_temperature": 50,
    "date": '2024-01-30',
    "zip_code": '98121'
  },
  {
    "address": 'Seattle, King County, 98121, Washington, United States',
    "average_temperature": 51,
    "highest_temperature": 55,
    "lowest_temperature": 46,
    "date": '2024-01-31',
    "zip_code": '98121'
  },
  {
    "address": 'Seattle, King County, 98121, Washington, United States',
    "average_temperature": 47,
    "highest_temperature": 58,
    "lowest_temperature": 37,
    "date": '2024-02-01',
    "zip_code": '98121'
  },
  {
    "address": 'Seattle, King County, 98121, Washington, United States',
    "average_temperature": 44,
    "highest_temperature": 52,
    "lowest_temperature": 37,
    "date": '2024-02-02',
    "zip_code": '98121'
  },
  {
    "address": 'Seattle, King County, 98121, Washington, United States',
    "average_temperature": 42,
    "highest_temperature": 48,
    "lowest_temperature": 38,
    "date": '2024-02-03',
    "zip_code": '98121'
  },
  {
    "address": 'Seattle, King County, 98121, Washington, United States',
    "average_temperature": 43,
    "highest_temperature": 48,
    "lowest_temperature": 37,
    "date": '2024-02-04',
    "zip_code": '98121'
  }
].each do |forecast|
  Forecast.find_or_create_by!(forecast)
end
