# frozen_string_literal: true

class ForecastsController < ApplicationController
  before_action :set_forecast, only: %i[show destroy]

  # GET /forecasts or /forecasts.json
  def index
    @forecasts = Forecast.recent.all
  end

  # GET /forecasts/1 or /forecasts/1.json
  def show
    render :show, locals: { cached: Rails.cache.exist?(@forecast.zip_code) }
  end

  # GET /forecasts/new
  def new; end

  # POST /forecasts or /forecasts.json
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

  # DELETE /forecasts/1 or /forecasts/1.json
  def destroy
    @forecast.destroy!

    respond_to do |format|
      format.html { redirect_to forecasts_url, notice: 'Forecast was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_forecast
    @forecast = Forecast.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, flash: { notice: 'Forecast not found' }
  end

  # Only allow a list of trusted parameters through.
  def forecast_params
    params.permit(:zip_code)
  end

  def cache_zip_code
    zip_code = forecast_params[:zip_code]
    Rails.cache.write(zip_code, true, expires_in: 30.minutes)
  end

  def read_cache_or_fetch_forecasts
    zip_code = forecast_params[:zip_code]

    if Rails.cache.exist?(zip_code)
      OpenStruct.new(success?: true, payload: zip_codes)
    else
      WeatherOrganizer.call(zip_code:)
    end
  end
end
