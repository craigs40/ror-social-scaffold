# rubocop:disable Lint/ShadowingOuterLocalVariable

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: :friendship, foreign_key: :friend_id
  has_many :sent_friendships, foreign_key: :sender_id, class_name: :Friendship
  has_many :received_friendships, foreign_key: :receiver_id, class_name: :Friendship
  has_many :requesting_friends, through: :received_friendships
  has_many :requested_friends, through: :sent_friendships

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array(inverse_friendships.map { |friendship| friendship.user if friendship.confirmed })
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end

# rubocop:enable Lint/ShadowingOuterLocalVariable
