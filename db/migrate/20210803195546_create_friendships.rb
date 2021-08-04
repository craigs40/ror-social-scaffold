class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend, index: true
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :status

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
    add_index :friendships, :sender_id
    add_index :friendships, :receiver_id
  end
end
