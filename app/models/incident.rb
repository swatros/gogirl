class Incident < ApplicationRecord
  CRIME_TYPES = ["unwanted physical contact", "stalking", "sexual assault", "theft", "derogatory comments", "violent assault", "threatening behavior"]
  belongs_to :user, optional: true
  belongs_to :journey, optional: true
  geocoded_by :location
  after_validation :geocode, if: :geocode?
  after_validation :reverse_geocode, if: :reverse_geocode?
  # validates :crime, inclusion: {in: CRIME_TYPES} # ADD REQUIRE:TRUE TO SIMPLE FORM ON SURVEY

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
