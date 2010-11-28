require 'spec_helper'

describe UsersController do

  TWITTER_TEST_URL = 'twitter_test.com'

  describe "GET 'new'" do
    it "redirects to twitter - stub example" do
      # see the extra message stub, I don't really need logged_in?
      oauth_service_stub = stub(:login_by_oauth => TWITTER_TEST_URL, :logged_in? => false)
      controller.stub!(:oauth_service).and_return(oauth_service_stub)

      get 'new'
      response.should redirect_to TWITTER_TEST_URL
    end

    it "redirects to twitter - mock example" do
      oauth_service_mock = mock(:oauth_service)
      oauth_service_mock.should_receive(:login_by_oauth).and_return(TWITTER_TEST_URL)
      # oauth_service_mock.should_receive(:logged_in).and_return(false)

      controller.stub!(:oauth_service).and_return(oauth_service_mock)

      get 'new'
      response.should redirect_to TWITTER_TEST_URL
    end
  end

  describe "Get 'callback'" do
    it "redirects to the home page when error occurs in oauth_service" do
      # I could use a mock
      # oauth_service = mock(:oauth_service)
      # oauth_service.should_receive(:get_user_info).with('xyz').and_raise(StandardError)
      # but a stub will exercise the code just fine
      oauth_service = stub(:oauth_service)
      oauth_service.stub!(:get_user_info).and_raise(StandardError)

      controller.stub!(:oauth_service).and_return(oauth_service)

      # Exercise
      get 'callback', {:oauth_verifier => 'xyz'}

      flash[:error].should == 'Twitter API failure (account login)'
      response.should redirect_to root_url
    end

    it "redirect's to the user's page after a successfull login" do
      user_info_stub = {'id' => '123456', 'screen_name' => 'johndoe', 'profile_image_url' => 'some_image_url'}
      oauth_service_mock = mock(OauthService, :access_token => '12345', :access_secret => 'abcde')
      oauth_service_mock.should_receive(:get_user_info).with('xyz').and_return(user_info_stub)
      user = User.new(:id => 122)
      User.stub!(:save_user!).and_return(user)

      controller.stub!(:oauth_service).and_return(oauth_service_mock)

      # Exercise
      get 'callback', {:oauth_verifier => 'xyz'}

      controller.current_user.should == user
      response.should redirect_to user
    end
  end

end
