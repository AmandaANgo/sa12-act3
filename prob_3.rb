require 'net/http'
require 'json'

API_KEY = 'OTHKhPhNe89ne3MhRP8gNHu6SE6bn8q9'
city = 'Memphis'
def get_events(city)
  url = URI("https://app.ticketmaster.com/discovery/v2/events.json?apikey=#{API_KEY}&city=#{city}")
  response = Net::HTTP.get(url)
  events_data = JSON.parse(response)
  events_data['_embedded']['events']
end

def display_events(events)
  events.each do |event|
    name = event['name']
    venue = event['_embedded']['venues'].first['name']
    date = event['dates']['start']['localDate']
    time = event['dates']['start']['localTime']
    date_time = "#{date} #{time}" if date && time
    puts "Event: #{name}"
    puts "Venue: #{venue}"
    puts "Date & Time: #{date_time}"
    puts "--------------------------------------"
  end
end

# Main
puts "Enter the city to search for events:"
city = gets.chomp
events = get_events(city)
if events.nil?
  puts "No events found in #{city}."
else
  puts "Upcoming events in #{city}:"
  display_events(events)
end