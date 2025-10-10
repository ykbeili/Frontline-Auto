class User < ApplicationRecord
  has_and_belongs_to_many :dealer
  enum :role, { staff: "staff", manager: "manager", owner: "owner" }
end
