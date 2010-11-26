class FollowersController < ApplicationController
  before_filter :authenticated_user!

  def index
    @followers = self.oauth_service.followers(@current_user)
    @followers
  rescue => err
    ::Rails.logger.error "Failed to get followers via OAuth for #{current_user.inspect}. Message: #{err.message}"
    flash[:error] = "Twitter API failure (getting followers)"
  end

  def oauth_service
    @oauth_service ||= OauthService.new(session)
    @oauth_service
  end
end
