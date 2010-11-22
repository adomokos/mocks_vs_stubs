$: << File.join(File.dirname(__FILE__), "lib")
require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec
end
