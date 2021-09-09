class Incident < ApplicationRecord
  CRIME_TYPES = ["unwanted physical contact", "stalking", "sexual assault", "theft", "derogatory comments", "violent assault", "threatening behavior"]
  belongs_to :user, optional: true
  belongs_to :journey, optional: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  # validates :crime, inclusion: {in: CRIME_TYPES} # ADD REQUIRE:TRUE TO SIMPLE FORM ON SURVEY
end
