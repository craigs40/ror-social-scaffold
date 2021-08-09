RSpec.describe 'Friend request' do
  it 'creates a friend request' do
    send_friend_request
    expect(page).to have_content('Friend request sent')
    expect(User.first.pending_friends.first).to eq(User.last)
    expect(User.last.friend_requests.first).to eq(User.first)
  end
end
