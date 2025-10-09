class AddDealerToVehicles < ActiveRecord::Migration[7.1]
  def change
    add_reference :vehicles, :dealer, null: false, foreign_key: true
  end
end
