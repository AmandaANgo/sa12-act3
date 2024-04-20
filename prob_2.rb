require 'httparty'
require 'json'

api_key = 'c56c0ce80d3efb4aa9fd65a85fab42aa'
from_currency = 'USD'
to_currency = 'JPY'
amount = 100

response = HTTParty.get("https://api.exchangerate-api.com/v4/latest/#{from_currency}?symbols=#{to_currency}")
data = JSON.parse(response.body)

if response.code == 200
  exchange_rate = data['rates'][to_currency]
  converted_amount = amount * exchange_rate
  puts "#{amount} #{from_currency} is equal to #{converted_amount.round(2)} #{to_currency}"
else
  puts "Error: #{data['error']}"
end