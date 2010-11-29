Feature: Login Users
  In order to access the full site
  As a user
  I want be able to log on to the site with my twitter account

  Scenario: Login via Twitter
    Given I am on the home page
    When I follow "sign_in_with_twitter"
     And Twitter authorizes me
    Then I should see "Welcome back!"
