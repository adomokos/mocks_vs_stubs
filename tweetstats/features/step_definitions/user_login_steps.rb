When /^I click on "([^"]*)"$/ do |alt_attribute|
  find(:xpath, "//a[@id='sign_in_with_twitter']").click
end

When /^Twitter authorizes me$/ do
  visit callback_users_path
end

Then /^I should be redirected to Twitter home page$/ do
  pending # express the regexp above with the code you wish you had
end
