Feature: View Friends
  In order to see who my friends are
  As a user
  I want to go to the 'friends' page and see my friends

  Background:
    Given I am logged on to the site

  Scenario: View friends
    When I follow "friends"
    Then I should see "You are following 98 friends."
