require 'httparty'
require 'json'

API_KEY = '93bc59bbd2acbcac40e13d6394866075'
CITY = 'Memphis'

def fetch_weather(city)
  response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{API_KEY}&units=imperial")
  return JSON.parse(response.body) if response.code == 200

  nil
end

def average_temperature(weather_data)
  hourly_temperatures = weather_data['hourly'] || []
  return "Hourly temperature data not available" if hourly_temperatures.empty?

  total_temperature = hourly_temperatures.sum { |data| data['temp'] }
  average_temperature = total_temperature / hourly_temperatures.size
  average_temperature.round(2)
end

weather_data = fetch_weather(CITY)

if weather_data
  temperature = weather_data['main']['temp']
  humidity = weather_data['main']['humidity']
  weather_conditions = weather_data['weather'].map { |weather| weather['description'] }.join(', ')

  puts "Current weather in #{CITY}:"
  puts "Temperature: #{temperature}°F"
  puts "Humidity: #{humidity}%"
  puts "Weather Conditions: #{weather_conditions}"

  puts "\nCalculating average temperature for #{CITY}..."
  average_temp = average_temperature(weather_data)
  puts "Average temperature over the next 24 hours: #{average_temp}"
else
  puts "Failed to fetch weather data for #{CITY}."
end
