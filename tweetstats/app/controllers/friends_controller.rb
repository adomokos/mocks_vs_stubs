class FriendsController < ApplicationController
  before_filter :authenticated_user!

  def index
    @friends = self.oauth_service.friends(@current_user)
    @friends
  rescue => err
    ::Rails.logger.error "Failed to get friends via OAuth for #{current_user.inspect}. Message: #{err.message}"
    flash[:error] = "Twitter API failure (getting friends)"
  end
end
