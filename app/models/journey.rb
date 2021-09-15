class Journey < ApplicationRecord
  belongs_to :user, optional: true
  has_many :incidents
  validates :origin_address, presence: true
  validates :destination_address, presence: true
end
