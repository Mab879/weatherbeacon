require 'net/http'
class ForcastController < ApplicationController
  def start
  end

  def redirect_to_forcast
    redirect_to forecast_url(:zip_code => params[:zip_code])
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
    @today_day_preicp = @forecast["forecast"]["simpleforecast"]["forecastday"][0]["pop"]
    @next_day_preicp = @forecast["forecast"]["simpleforecast"]["forecastday"][1]["pop"]
    @preicp = calc_mean(@today_day_preicp, @next_day_preicp)
    @alerts_uri = "http://i.wxbug.net/REST/Direct/GetAlert.ashx?zip=#{params[:zip_code]}&api_key=nuju3g8vbn3puwbrqnyphejd"
    @alerts_resp = WeatherApi.get(@alerts_uri).to_json
    @alerts_json = JSON.parse(@alerts_resp)
    @alerts = @alerts_json["alertList"]
  end

  private

  def calc_mean(val1, val2)
    total = val1 + val2
    total / 2
  end
end
