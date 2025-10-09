class CreateVehicles < ActiveRecord::Migration[7.1]
  def change
    create_table :vehicles do |t|
      t.integer :year
      t.string :make
      t.string :model
      t.string :trim
      t.string :vin
      t.string :stock_no
      t.string :status
      t.string :recon_state
      t.string :source
      t.string :drivetrain
      t.string :transmission
      t.string :fuel
      t.string :engine
      t.integer :cylinders

      t.timestamps
    end
  end
end
