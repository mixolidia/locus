class Address < ApplicationRecord
  belongs_to :city
  belongs_to :state
  belongs_to :coordinate
  has_many :venues
end
