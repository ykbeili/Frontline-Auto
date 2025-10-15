class Dealer < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :vehicles, dependent: :destroy
end
