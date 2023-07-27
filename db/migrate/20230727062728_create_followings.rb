class CreateFollowings < ActiveRecord::Migration[7.0]
  def change
    create_table :followings, id: false do |t|
      t.integer :follower_id
      t.integer :followed_id
    end

    add_index :followings, [:follower_id, :followed_id], unique: true

    # Tạo các liên kết với bảng users
    add_foreign_key :followings, :users, column: :follower_id
    add_foreign_key :followings, :users, column: :followed_id
  end
end
