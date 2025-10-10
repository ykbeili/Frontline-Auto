class Dealer < ApplicationRecord
  has_and_belongs_to_many :users, dependent: :destroy
  has_many :vehicles, dependent: :destroy
end
