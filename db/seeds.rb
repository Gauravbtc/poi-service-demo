# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


via

https://maps.googleapis.com/maps/api/directions/json?
origin=Boston,MA&destination=Concord,MA
&waypoints=via:Charlestown,MA|via:Lexington,MA
&departure_time=now
&key=YOUR_API_KEY



If you pass latitude/longitude coordinates, the values go directly to the front-end server to calculate directions without geocoding. The points are snapped to roads and might not provide the accuracy your app needs. Use coordinates when you are confident the values truly specify the points your app needs for routing without regard to possible access points or additional geocoding details. Ensure that a comma (%2C) and not a space (%20) separates the latitude and longitude values.


longitude and langitude

https://maps.googleapis.com/maps/api/directions/json?
origin=sydney,au&destination=perth,au
&waypoints=via:-37.81223%2C144.96254%7Cvia:-34.92788%2C138.60008
&key=YOUR_API_KEY

geocoded_waypoints: contains information related to between origin to destination

Directions response elements
Directions responses contain the following root elements:

status contains metadata on the request. See Status Codes below.
geocoded_waypoints contains an array with details about the geocoding of origin, destination and waypoints. See Geocoded Waypoints below.
routes contains an array of routes from the origin to the destination. See Routes below. Routes consist of nested Legs and Steps.
available_travel_modes contains an array of available travel modes. This field is returned when a request specifies a travel mode and gets no results. The array contains the available travel modes in the countries of the given set of waypoints. This field is not returned if one or more of the waypoints are via: waypoints. See details below.


check routes contains routes information

legs contains
start and end_location

start_addres, end_adddress it's lat and lng information


https://developers.google.com/maps/documentation/directions/overview#Steps

stps contains details each and evey step information similar to go to 100 m then turn left then right and all


## sample testing api


https://maps.googleapis.com/maps/api/directions/json?
origin=origin=36.0604105,140.1224959196333&destination=36.07351825,140.10338919911263
&waypoints=via:36.066049%2C140.1175602
&key=AIzaSyDg94En_Kv4f0BIt2ZZvNnSb-Pllx8UGvk

https://maps.googleapis.com/maps/api/directions/json?
origin=36.0604105,140.1224959196333&destination=36.07351825,140.10338919911263
&waypoints=via:36.066049%2C140.1175602
&key=AIzaSyDg94En_Kv4f0BIt2ZZvNnSb-Pllx8UGvk


lala gardern to vebuin

https://maps.googleapis.com/maps/api/directions/json?
origin=36.07351825,140.10338919911263&destination=36.066049,140.1175602
&key=AIzaSyDg94En_Kv4f0BIt2ZZvNnSb-Pllx8UGvk



set alernate to true for getting alternative routes

https://maps.googleapis.com/maps/api/directions/json?
origin=36.07351825,140.10338919911263&destination=36.066049,140.1175602&alternatives=true
&key=AIzaSyDg94En_Kv4f0BIt2ZZvNnSb-Pllx8UGvk

RestClient.get 'https://maps.googleapis.com/maps/api/directions/json', {params: {"origin": 36.0604105,140.1224959196333, "destination": destination=36.07351825,140.10338919911263, "key": "AIzaSyDg94En_Kv4f0BIt2ZZvNnSb-Pllx8UGvk"}}








