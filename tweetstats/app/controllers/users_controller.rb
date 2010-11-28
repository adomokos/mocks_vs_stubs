class UsersController < ApplicationController

  # Used this example: https://github.com/tardate/rails-twitter-oauth-sample
  # include OauthSystem

  before_filter :oauth_login_required, :except => [ :callback, :signout, :index ]

  def index
  end

  def new
    # this is a do-nothing action, provided simply to invoke authentication
    # on successful authentication, user will be redirected to 'show'
    # on failure, user will be redirected to 'index'
  end

  def show
    @user = self.current_user
  end

  def signout
    self.current_user = false 
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end

  # controller method to handle twitter callback (expected after login_by_oauth invoked)
  def callback
    user_info = self.oauth_service.get_user_info(params[:oauth_verifier])

    # We have an authorized user, save the information in the database.
    @user = User.save_user!({
        :twitter_id => user_info['id'],
        :screen_name => user_info['screen_name'],
        :token => self.oauth_service.access_token,
        :secret => self.oauth_service.access_secret,
        :profile_image_url => user_info['profile_image_url']
    })
    if @user
      self.current_user = @user
    else
      raise OauthSystem::RequestError
    end
    # Redirect to the show page
    redirect_to @user
  rescue Exception => e
    # The user might have rejected this application. Or there was some other error during the request.
    ::Rails.logger.error "Failed to get user info via OAuth - exception msg: #{e.message}"
    flash[:error] = "Twitter API failure (account login)"
    redirect_to root_url
  end

private

  def oauth_login_required
    logged_in? || login_by_oauth
  end

  # Returns true or false if the user is logged in.
  # Preloads @current_user with the user model if they're logged in.
  def logged_in?
    !!current_user
  end

  def login_by_oauth
    redirect_to self.oauth_service.login_by_oauth
  rescue Exception => e
    # The user might have rejected this application. Or there was some other error during the request.
    ::Rails.logger.error "Failed to login via OAuth - Exception: #{e.message}"
    flash[:error] = "Twitter API failure (account login)"
    redirect_to root_url
  end

end
