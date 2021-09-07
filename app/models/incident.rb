class Incident < ApplicationRecord
  belongs_to :user, optional: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
