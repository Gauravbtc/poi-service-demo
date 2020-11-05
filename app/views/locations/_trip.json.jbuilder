json.extract! trip, :id, :address, :latitude, :langitude, :created_at, :updated_at
json.url trip_url(trip, format: :json)
