$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rubyflare'
require 'vcr'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random
end
