class Coordinate < ApplicationRecord
  has_many :addresses
  has_many :meetings
end
