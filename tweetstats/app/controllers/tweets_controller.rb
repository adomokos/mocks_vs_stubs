class TweetsController < ApplicationController
  before_filter :authenticated_user!

  def create
    # self.oauth_service.update_status!(@current_user, params[:tweet_message])
    flash[:notice] = "Tweet has been sent"
    redirect_to root_path
  rescue => err
    ::Rails.logger.error "Failed to post tweet message via OAuth for #{current_user.inspect}. Message: #{err.message}"
    flash.now[:error] = "Twitter API failure (sending tweet message)"
    render :action => 'new'
  end

end
