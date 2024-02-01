# Weather Forecast Coding Assignment

## General Overview (Non-Technical) 

- The Weather Forecast application utilizes the 3rd party API provided by [https://www.tomorrow.io/](https://www.tomorrow.io/) to fetch and display the current weather forecast for a given location.

- In addition the application will avoid making repeated calls the API endpoint for the same address within the 30 minute cache window as indicated in the description for the assignment.

> [!NOTE]
>  For simplicity the UI was reduced from a generic address input form to just a US Zip-Code lookup as city and street name ambiguity was generating too much scope creep.

### Quick System Design

![sys_design](https://github.com/taywils/weather_forecast/assets/833843/d0f95063-cec4-4bf4-80ce-8dda283e6234)

1. User inputs a valid zip code
2. Rails backend checks cache OR reaches out to 3rd party Weather API
3. Optionally writes cache and commits to database
4. Returns output

## Technical Overview

- The objective was to transform API calls to `https://api.tomorrow.io/v4/weather/forecast` into `Forecast` models in the Rails Application

```json
  {
    "address": "Seattle, King County, 98121, Washington, United States",
    "average_temperature": 53,
    "highest_temperature": 55,
    "lowest_temperature": 50,
    "date": "2024-01-30",
    "zip_code": "98121"
  }
```

- Eventually displaying it to end users with a description if the data was cached

![forecast_ui](https://github.com/taywils/weather_forecast/assets/833843/fa3f55e2-a925-464d-9c00-9ce921d7c9b7)


### Unit Tests/Spec Testing

- Rspec was used as the primary test driver.
- HTTP request stub testing was introduced to simulate calling the 3rd Party Weather API
- ActiveRecord models were used in conjunction with the `Weather Service Object` to increase SOLID design
```
spec
├── factories
│   └── forecasts.rb
├── fixtures
│   ├── tomorrow_io_response.json
│   └── weather_parser_output.json
├── helpers
│   └── forecasts_helper_spec.rb
├── models
│   └── forecast_spec.rb
├── rails_helper.rb
├── routing
│   └── forecasts_routing_spec.rb
├── services
│   ├── weather_builder_spec.rb
│   ├── weather_fetcher_spec.rb
│   └── weather_parser_spec.rb
├── spec_helper.rb
└── support
    └── factory_bot.rb
```

### Service Object Composition

In developing the Weather Forecast application, I aimed to illustrate my approach to writing Rails Controller classes by showcasing the implementation of Service Objects. These Service Objects are utilized to maintain the size of Restful operations in a manageable manner.

```ruby
# app/controllers/forecasts_controller.rb

  # POST /forecasts
  def create
    result = read_cache_or_fetch_forecasts

    cache_zip_code if result.success?

    respond_to do |format|
      if result.success?
        format.html { redirect_to root_path, notice: 'Successful request!' }
      else
        flash.now[:notice] = result.error
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
```

- There is very little "Controller Bloat" since the primary code for fetching the response from the Weather API is composed of chainable service objects

```
app/services
├── weather_builder.rb
├── weather_fetcher.rb
├── weather_organizer.rb
└── weather_parser.rb
```

### WeatherFetcher -> WeatherParser -> WeatherBuilder

Each of the `WeatherOrganizer` steps is built using the https://github.com/collectiveidea/interactor Gem.

> [!NOTE]
> Each Service Object nested under the WeatherOrganizer can be fully decoupled and tested in isolation.
> In addition if any single step fails the entire process is halted and exceptions can be safely rescued

- `WeatherFetcher` Service is a "Wrapper Pattern" around the [Faraday](https://github.com/lostisland/faraday) HTTP client library
  - It encapsulates the API calls and hides the implementation and successfully passes the json response to the next service
 
- `WeatherParser` Service then consumes the JSON response from the Fetcher and transforms it into POROs "Plain Old Ruby Objects"

- `WeatherBuilder` Service is a "Factory Pattern" to build the ActiveRecord Forecast Models

### WeatherOrganizer

All together the "WeatherOrganizer" class chains each service together; in the future one could easily add any number of hooks or complex middleware in a parallel and isolated fashion.

```ruby
class WeatherOrganizer
  include Interactor::Organizer

  # The interactors are run in the order they are listed.
  # The `context` of each interactor is passed to the next interactor in the chain.
  organize WeatherFetcher, WeatherParser, WeatherBuilder
end
```

To use the `WeatherOrganizer` is a simple `call` providing the arguments to the first service in the chain

```ruby
result = WeatherOrganizer.call(zip_code: your_zip_code_here)

if result.success?
  # process result
else
  # handle result.error
end
```

### Cache Strategy

- As outlined in the description I used the suggested `30 minute` time window for TTL
- Its never a great idea to `cache entire ActiveRecord Objects` so instead we need some serialized format or a simple `cache key`
- I used the `Forecast.zip_code` as the cache key

```ruby
# app/controllers/forecasts_controller.rb

  def cache_zip_code
    Rails.cache.write(forecast_params[:zip_code], true, expires_in: 30.minutes)
  end

  def read_cache_or_fetch_forecasts
    zip_code = forecast_params[:zip_code]

    if Rails.cache.exist?(zip_code)
      OpenStruct.new(success?: true, payload: zip_codes)
    else
      WeatherOrganizer.call(zip_code:)
    end
  end
```

- When the cache key is found we skip the API endpoint call and rely on Application State instead

## Web UI Notes

- In addition to client side validation I also took advantage of https://github.com/dgilperez/zip-codes to perform US ZipCode validation

![zipcode_validation](https://github.com/taywils/weather_forecast/assets/833843/137aa5aa-fa7b-468e-bcf2-af2f11b1dce4)

- The Service Object composition allows us to short-circuit and send an early `fail!` notification 

```ruby
# app/services/weather_fetcher.rb
class WeatherFetcher
  include Interactor

  before do
    context.fail!(error: 'Invalid Zipcode') if context.zip_code.blank? || ZipCodes.identify(context.zip_code).blank?
  end
```

### Web UI Possible Extensions/Future Work

![homepage](https://github.com/taywils/weather_forecast/assets/833843/78723df5-cf93-43f5-b453-e5f554327ceb)

- Given that each API request generates a Five-Day forecast it would be `nice to display a graph of the temperatures`
- `Filtering by location or Date` is possible with a few SQL queries on the `Forecast` models
- Geolocation data could be used to `pre-set the user's zipcode based on IP address` assuming the user agrees to terms&conditions
