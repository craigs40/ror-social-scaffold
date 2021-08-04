class FriendshipsController < ApplicationController
  def index
    @friends = current_user.friends
    @friend_requests = current_user.friend_requests
  end

  def create
    @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id], confirmed: params[:c])
    if @friendship.save
      redirect_to root_path, notice: 'Friend request sent'
    else
      redirect_to root_path, alert: 'Unable to send friend request'
    end
  end

  def update
    @friendship = current_user.inverse_friendships.find_by(user_id: params[:id])
    if @friendship
      @friendship.update(confirmed: true)
      redirect_to root_path, notice: 'Friend request accepted'
    else
      redirect_to root_path, alert: 'Unable to send friend request'
    end
  end

  def delete_friend
    @friendship = Friendship.find(params[:id])
    if @friendship
      @friendship.destroy
      redirect_to user_friendships_path, notice: 'Friend deleted'

    else
      redirect_to user_friendships_path, alert: 'Unable to delete friend'
    end
  end

  def cancel_request
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    if @friendship
      @friendship.destroy
      redirect_to root_path, notice: 'Friend request canceled'
    else
      redirect_to root_path, notice: 'Unable to cancel friend request'
    end
  end

  def decline_request
    @friendship = current_user.inverse_friendships.find_by(user_id: params[:id])
    if @friendship
      @friendship.destroy
      redirect_to user_friendships_path, notice: 'Friend request declined'
    else
      redirect_to user_friendship_path, alert: 'Unable to decline request'
    end
  end
end
