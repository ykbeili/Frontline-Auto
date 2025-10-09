class AddDealerToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :dealer, null: false, foreign_key: true
  end
end
