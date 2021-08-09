RSpec.describe 'Friend request' do
  let(:create_friendship) do
    it 'creates a friend request' do
      Friendship.new(user_id: User.first.id, friend_id: User.last.id, confirmed: false)
    end
  end
end
