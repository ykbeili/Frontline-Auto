class User < ApplicationRecord
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :dealers
  enum :role, { staff: "staff", manager: "manager", owner: "owner" }
  attr_accessor :dealer_name
end