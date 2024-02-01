# frozen_string_literal: true

class ForecastsController < ApplicationController
  before_action :set_forecast, only: %i[show destroy]

  # GET /forecasts or /forecasts.json
  def index
    @forecasts = Forecast.recent.all
  end

  # GET /forecasts/1 or /forecasts/1.json
  def show; end

  # GET /forecasts/new
  def new; end

  # GET /forecasts/1/edit
  # def edit; end

  # POST /forecasts or /forecasts.json
  def create
    result = WeatherOrganizer.call(zip_code: params.permit(:zip_code)[:zip_code])

    respond_to do |format|
      if result.success?
        format.html { redirect_to root_path, notice: 'Forecast was successfully created.' }
      else
        flash.now[:notice] = result.error
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forecasts/1 or /forecasts/1.json
  # def update; end

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
end
