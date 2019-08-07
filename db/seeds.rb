# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# comes in from form
FL = 'FL'
API_KEY = '41150c82c3014e3a87abb252f65ef0bb'
ADDRESS_TO_COORDINATES_URL_TEMPLATE = "https://ssll.dokku-hosted.thruhere.net/?api_key=#{API_KEY}&"
COORDINATES_TO_MIDPOINT_URL_TEMPLATE = "https://miim.dokku-hosted.thruhere.net/midpoint?api_key=#{API_KEY}&"
field_names = %w[STREET CITY]

puts "The user is presented with a form with #{field_names.join(', ')} fields."
text_input = '2560 NW 5th Ave, Miami'
street, city_value = text_input.split(', ')

[street, city_value].map{|item| item.downcase}.zip(field_names).each do |value, field|
    puts "The user enters value \"#{value}\" for field \"#{field}\"."
    sleep 1
end

city = City.find_or_create_by(value: city_value)
state = State.find_or_create_by(value: 'FL')
address_a = Address.find_or_create_by(street: street) do |address|
    address.city = city
    address.state = state
end
a_point = URI::encode([street, city_value, FL].join(', '))

puts "The user is presented with a form with #{field_names.join(', ')} fields."
text_input = '411 Clematis St, West Palm Beach'
street, city_value = text_input.split(', ')

[street, city_value].map{|item| item.downcase}.zip(field_names).each do |value, field|
    puts "The user enters value \"#{value}\" for field \"#{field}\"."
    sleep 1
end
city = City.find_or_create_by(value: city_value)
state = State.find_or_create_by(value: FL)
address_b = Address.find_or_create_by(street: street) do |address|
    address.city = city
    address.state = state
end


puts "Next the addresses have to be converted to coordinates."
ADDRESSES = [address_a, address_b,]

[
    [address_a.street, address_a.city.value, FL, address_a],
    [address_b.street, address_b.city.value, FL, address_b],
].each do |street, city, state, address_|
    params = {street: street, city: city, state: state}.to_param
    url = "#{ADDRESS_TO_COORDINATES_URL_TEMPLATE}#{params}"
    # HTTP client to get info from web API.
    response = HTTParty.get(url)
    coordinates = response.parsed_response.fetch('data').fetch('coordinates')
    coordinate = Coordinate.find_or_create_by(lat: coordinates['latitude']) do |item|
        item.lon = coordinates['longitude']
    end
    address_.coordinate = coordinate
    address_.save
    p address_
end

puts "Next get the midpoint."
params = {
    a_point: [
        address_a.coordinate.lat,
        address_a.coordinate.lon,
    ].join(','),
    b_point: [
        address_b.coordinate.lat,
        address_b.coordinate.lon,
    ].join(',')
}.to_param.gsub(/%2C/, ',') # encodes the hash into a query string, web API expects commas so substitute
midpoint_url = "#{COORDINATES_TO_MIDPOINT_URL_TEMPLATE}#{params}" # API expects commas
response = HTTParty.get(midpoint_url).parsed_response
midpoint = response.fetch('response').fetch('midpoint')
midpoint_coordinate = Coordinate.find_or_create_by(lat: midpoint.fetch('lat')) do |item|
    item.lon = midpoint.fetch('lon')
end

p midpoint_coordinate

puts "Use #{midpoint_coordinate.lat}, #{midpoint_coordinate.lon} with the YELP API to get the surrounding businesses."

# Using faker here to fake out the data.

user = User.find_or_create_by(first_name: Faker::Name.first_name) do |item|
    item.last_name = Faker::Name.last_name
    item.mobile = Faker::PhoneNumber.phone_number
end
# This is all fake. It will come from the Yelp API.
# Based on the coordinates.
address = Address.find_or_create_by(street: Faker::Address.street_address) do |item|
    item.city = City.find_or_create_by(value: Faker::Address.city)
    item.state = State.find_or_create_by(value: FL)
    item.coordinate = Coordinate.all.sample
end
midpoint_coordinate.addresses << address
venue = Venue.find_or_create_by(name: Faker::Restaurant.name, address: address)
p venue
meeting = Meeting.find_or_create_by(coordinate: midpoint_coordinate, user: user)
meeting.save!
p meeting
