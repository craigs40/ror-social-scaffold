class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :user
  def confirm_friend
    update_attributes(confirmed: true)
    Friendship.create!(friend_id: user_id, user_id: friend_id, confirmed: true)
  end
end
