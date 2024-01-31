# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'forecasts/index', type: :view do
  before do
    assign(:forecasts, [
             Forecast.create!,
             Forecast.create!
           ])
  end

  it 'renders a list of forecasts' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
