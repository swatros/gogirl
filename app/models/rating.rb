class Rating < ApplicationRecord
  belongs_to :user, optional: true
end
