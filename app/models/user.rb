class User < ApplicationRecord
  belongs_to :dealer
  enum :role, { staff: "staff", manager: "manager" }
end
