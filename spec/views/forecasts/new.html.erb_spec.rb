# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'forecasts/new', type: :view do
  before do
    assign(:forecast, Forecast.new)
  end

  it 'renders new forecast form' do
    render

    assert_select 'form[action=?][method=?]', forecasts_path, 'post' do
    end
  end
end
