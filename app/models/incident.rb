class Incident < ApplicationRecord
  attr_accessor :location_needs_validation
  attr_accessor :crime_needs_validation
  # validates :location, presence: true, if: -> {location_needs_validation}


  CRIME_TYPES = ["Derogatory comments", "Theft", "Stalking/following", "Verbally threatening behavior", "Unwanted physical contact", "Sexual assault", "Violent (nonsexual) assault", "Other"]
  belongs_to :user, optional: true
  belongs_to :journey, optional: true
  geocoded_by :location
  after_validation :geocode, if: :geocode?
  after_validation :reverse_geocode, if: :reverse_geocode?
  validates :time, presence: true
  validates :date, presence: true
  # validates :location, presence: true
  # validates :crime, inclusion: {in: CRIME_TYPES} # REQUIRED:TRUE IN SIMPLE FORM ON SURVEY DOES THIS ALREADY

  def reverse_geocode
    self.location = Geocoder.search([latitude, longitude]).first.address
  end

  def geocode?
    location && will_save_change_to_location?
  end

  def reverse_geocode?
    !geocode?
  end
end
