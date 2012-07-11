module Refinery
  module Polls
    class Vote < Refinery::Core::BaseModel
    
      acts_as_indexed :fields => [:question_id, :answer_id, :ip]

      belongs_to :question, :class_name => '::Refinery::Polls::Question'
      belongs_to :answer, :class_name => '::Refinery::Polls::Answer'
      
      attr_accessible :question_id, :answer_id, :ip
      
      def self.vote_by_ip(question_id, answer_id, ip)
        self.create(:answer_id => answer_id, :question_id => question_id, :ip => ip)
      end
      def self.get_vote(question, ip)
        where("question_id=? AND ip=?", question.id, ip).first
      end
    end
  end
end