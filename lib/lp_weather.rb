class LPWeather

require 'forecast_io'
require 'yaml'

CONSTANT_APIKEY = 'a39b558ae58725100f87d10aeaeaea46'
CONSTANT_LATITUDE = 38.8617745
CONSTANT_LONGITUDE = -77.087159 

def weather
	icons = YAML::load_file "./lib/icons.yml"

	ForecastIO.configure do |configuration|
		configuration.api_key = CONSTANT_APIKEY
	end
	forecast = ForecastIO.forecast(CONSTANT_LATITUDE, CONSTANT_LONGITUDE)
	forecastHash = forecast.currently.to_hash
	icon = forecastHash['icon']
	
	lightObject = icons[icon]
	if !lightObject 
		return icons['clear-day']
	else
		return lightObject
	end
end

end