require 'active_support/core_ext/numeric/time'
module Refinery
  module Polls
    include ActiveSupport::Configurable
    
    config_accessor :vote_duration
    
    self.vote_duration = 1.week

  end
end