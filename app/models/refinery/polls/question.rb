module Refinery
  module Polls
    class Question < Refinery::Core::BaseModel
    
      translates :title, :slug

      extend FriendlyId
      friendly_id :title, :use => [:slugged, :globalize]
    
      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :uniqueness => true
      
      attr_accessible :title, :start_date, :end_date, :position
      attr_accessor :locale
      
      default_scope order("position ASC")
      
      class Translation
        attr_accessible :locale
      end
      
      def self.translated
        with_translations(::Globalize.locale)
      end
      
      has_many :answers, :class_name => '::Refinery::Polls::Answer'
      
      # Get all actives questions by start_date and end_date
      #
      # @return [Array] Array of Refinery::Polls::Question
      def self.actives
        where("start_date <= ? and end_date >= ?", Date.today, Date.today)
      end
      
      # Check if we have a vote by ip address
      #
      # @param [String] A string to represent an IP address
      # @return [::Refinery::Polls::Vote, nil] Returns the vote finded or nil
      def already_voted?(remote_ip)
        answers.joins(:votes).where(Refinery::Polls::Vote.table_name.to_sym => {:created_at => Time.now.utc - Refinery::Polls.vote_duration, :ip => remote_ip}).first
      end
      
      # Get al data for answers and total votes count
      #
      # @return [Array] Returns an array with [[title,votes_count]..[title,votes_count]], total_votes]
      def answers_with_data
        return answers.map(&:data_result), total_votes
      end
      
      # Calculate the total votes for current question
      #
      # @return [Integer] Returns the value of total votes
      def total_votes
        answers.sum(&:votes_count)
      end
      
      class << self
        def find_by_slug_or_id(slug_or_id)
          if slug_or_id.friendly_id?
            find_by_slug(slug_or_id)
          else
            find(slug_or_id)
          end
        end
      end
    end
  end
end
