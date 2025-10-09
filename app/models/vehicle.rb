class Vehicle < ApplicationRecord
  belongs_to :dealer
  has_many_attached :photos
end
