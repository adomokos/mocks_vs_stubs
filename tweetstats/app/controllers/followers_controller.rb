class FollowersController < ApplicationController
  before_filter :authenticated_user!

  def index
    @followers = self.oauth_service.followers(@current_user)
    @followers
  rescue => err
    ::Rails.logger.error "Failed to get followers via OAuth for #{current_user.inspect}. Message: #{err.message}"
    flash[:error] = "Twitter API failure (getting followers)"
  end

end
