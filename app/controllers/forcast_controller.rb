require 'net/http'
class ForcastController < ApplicationController
  def start
  end

  def redirect_to_forcast
    redirect_to display_url(:zip_code => params[:zip_code])
  end
  def display
  

    @city_uri = "http://api.wunderground.com/api/a23fbb5e040cfcef/conditions/q/#{params[:zip_code]}.json"  
    @city_resp = WeatherApi.get(@city_uri).to_json
    @city = JSON.parse(@city_resp)
    @forecast_uri = "http://api.wunderground.com/api/a23fbb5e040cfcef/forecast/q/#{params[:zip_code]}.json" 
    @forecast_resp = WeatherApi.get(@forecast_uri).to_json
    @forecast = JSON.parse(@forecast_resp)
    @todays_high = @forecast["forecast"]["simpleforecast"]["forecastday"][0]["high"]["fahrenheit"]
    @next_day_high = @forecast["forecast"]["simpleforecast"]["forecastday"][1]["high"]["fahrenheit"]
    @preicp = @forecast["forecast"]["simpleforecast"]["forecastday"][1]["pop"]
  end
end
