module Refinery
  module Polls
    class Vote < Refinery::Core::BaseModel
    
      acts_as_indexed :fields => [:question_id, :answer_id, :ip]

      belongs_to :question, :class_name => '::Refinery::Polls::Question'
      belongs_to :answer, :class_name => '::Refinery::Polls::Answer'
      
      attr_accessible :question_id, :answer_id, :ip
      
      # Create Vote for Question, Answer and IP
      # @param [::Refinery::Polls::Question] Question object
      # @parama [::Refinery::Polls::Answer] Answer object
      # @return [::Refinery::Polls::Vote] Vote object created
      
      def self.vote_by_ip(answer, ip)
        self.create(:answer_id => answer.id, :question_id => answer.question.id, :ip => ip)
      end
      
      # Find vote for Question by IP
      # @param [::Refinery::Polls::Question] Question object
      # @parama [Request] Request object to use remote_ip
      # @return [::Refinery::Polls::Vote] Vote object created
      def self.get_vote(question, ip)
        if ip.is_a?(String) && question.is_a?(::Refinery::Polls::Question)
          where("question_id=? AND ip=? AND created_at > ?", question.id, ip, Time.now - Refinery::Polls.vote_duration).first
        else
          nil
        end
      end
    end
  end
end