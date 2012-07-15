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
      
      def self.actives
        where("start_date <= ? and end_date >= ?", Date.today, Date.today)
      end
      
      def already_voted?(remote_ip)
        answers.joins(:votes).where(Refinery::Polls::Vote.table_name.to_sym => {:created_at => Time.now.utc - Refinery::Polls.vote_duration, :ip => remote_ip}).first
      end
      
      def answers_with_data
        return answers.map(&:data_result), total_votes
      end
      
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
      # def self.active_poll(user_id)
      #   users_polls = UsersPoll.find_all_by_user_id(user_id, :select => :poll_id)
      #   polls = users_polls.count > 0 ? Poll.active.find(:all, :conditions => ["id NOT IN (?)", users_polls.collect {|up| up.poll_id } ]) : Poll.active
      #   polls.count > 0 ? polls.first : nil
      # end
    end
  end
end
