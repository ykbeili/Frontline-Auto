class RemoveDealerFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :users, :dealer, null: false, foreign_key: true
  end
end
