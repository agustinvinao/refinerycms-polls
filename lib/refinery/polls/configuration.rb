module Refinery
  module Polls
    include ActiveSupport::Configurable
    
    config_accessor :test_value
    
    self.test_value = 0

  end
end