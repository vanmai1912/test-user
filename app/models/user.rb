class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:user_name]
  
  
  mount_uploader :avatar, AvatarUploader

  has_and_belongs_to_many :followers, class_name: "User", join_table: :followings, foreign_key: :followed_id, association_foreign_key: :follower_id
  has_and_belongs_to_many :followings, class_name: "User", join_table: :followings, foreign_key: :follower_id, association_foreign_key: :followed_id

  # Method để thêm user vào danh sách followings của user hiện tại
  def follow(user)
    followings << user
  end


end
