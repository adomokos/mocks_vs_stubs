class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user

  # Accesses the current user from the session.
  # Future calls avoid the database because nil is not equal to false.
  def current_user
    @current_user ||= (login_from_session) unless @current_user == false
  end

  def login_from_session
    self.current_user = User.find_by_twitter_id(session[:twitter_id]) if session[:twitter_id]
  end

  # Sets the current_user, including initializing the OAuth agent
  def current_user=(new_user)
    if new_user
      session[:twitter_id] = new_user.twitter_id
      # self.oauth_service.twitagent( user_token = new_user.token, user_secret = new_user.secret )
      @current_user = new_user
    else
      session[:request_token] = session[:request_token_secret] = session[:twitter_id] = nil
      # self.oauth_service.twitagent = false
      @current_user = false
    end
  end
end
