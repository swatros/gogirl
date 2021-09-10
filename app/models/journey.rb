class Journey < ApplicationRecord
  belongs_to :user, optional: true
  has_many :incidents
end
