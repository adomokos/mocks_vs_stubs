class OauthService
  attr_reader :twitagent

  def initialize(session)
    @session = session
  end

  def twitagent( user_token = nil, user_secret = nil )
    self.twitagent = TwitterOauth.new( user_token, user_secret )  if user_token && user_secret
    self.twitagent = TwitterOauth.new( ) unless @twitagent
    @twitagent ||= raise OauthSystem::NotInitializedError
  end

  def twitagent=(new_agent)
    @twitagent = new_agent || false
  end

  def login_by_oauth
    request_token = self.twitagent.get_request_token
    @session[:request_token] = request_token.token
    @session[:request_token_secret] = request_token.secret
    request_token.authorize_url
  end

  def get_user_info(oauth_verifier)
    self.twitagent.exchange_request_for_access_token( @session[:request_token], @session[:request_token_secret], oauth_verifier )
    user_info = self.twitagent.verify_credentials
    raise OauthSystem::RequestError unless user_info['id'] && user_info['screen_name'] && user_info['profile_image_url']

    user_info
  end

  def access_token
    self.twitagent.access_token.token
  end

  def access_secret
    self.twitagent.access_token.secret
  end

  def followers(user)
    self.twitagent(user.token, user.secret).followers(user.screen_name)
  end

  def friends(user)
    self.twitagent(user.token, user.secret).friends(user.screen_name)
  end

# Twitter REST API Method: statuses/update
  def update_status!(user, status, in_reply_to_status_id = nil)
    self.twitagent(user.token, user.secret).update_status!(status, in_reply_to_status_id)
	end

end
