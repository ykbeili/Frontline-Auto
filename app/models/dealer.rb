class Dealer < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :vehicles, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end