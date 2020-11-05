class Location < ApplicationRecord

  # relations
  belongs_to :user
  # call backs
  before_save :geocode

  # validations
  validates_presence_of :user_id, :address

  ## combine city state and address
  ## Geocode settings
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

end
