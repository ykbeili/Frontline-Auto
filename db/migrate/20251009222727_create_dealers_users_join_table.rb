class CreateDealersUsersJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :dealers, :users do |t|
      # t.index [:dealer_id, :user_id]
      # t.index [:user_id, :dealer_id]
    end
  end
end
