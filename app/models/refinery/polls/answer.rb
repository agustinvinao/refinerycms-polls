module Refinery
  module Polls
    class Answer < Refinery::Core::BaseModel   
    
      translates :title, :slug
      extend FriendlyId
      friendly_id :title, :use => [:slugged, :globalize]
    
      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :uniqueness => true
      
      attr_accessible :title, :question_id, :position
      attr_accessor :locale
      
      belongs_to :question, :class_name => '::Refinery::Polls::Question'
      has_many :votes, :class_name => '::Refinery::Polls::Vote'
      
      default_scope order("position ASC")

      class Translation
        attr_accessible :locale
      end
      
      def dom_id
        "answer_#{id}"
      end
      
      def self.translated
        with_translations(::Globalize.locale)
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