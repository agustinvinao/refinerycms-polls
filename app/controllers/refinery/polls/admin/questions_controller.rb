module Refinery
  module Polls
    module Admin
      class QuestionsController < ::Refinery::AdminController

        crudify :'refinery/polls/question', :title_attribute => 'title', :xhr_paging => true

      end
    end
  end
end
