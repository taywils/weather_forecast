# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'forecasts/show', type: :view do
  before do
    assign(:forecast, Forecast.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
