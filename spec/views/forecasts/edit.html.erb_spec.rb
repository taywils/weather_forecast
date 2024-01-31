# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'forecasts/edit', type: :view do
  let(:forecast) do
    Forecast.create!
  end

  before do
    assign(:forecast, forecast)
  end

  it 'renders the edit forecast form' do
    render

    assert_select 'form[action=?][method=?]', forecast_path(forecast), 'post' do
    end
  end
end
