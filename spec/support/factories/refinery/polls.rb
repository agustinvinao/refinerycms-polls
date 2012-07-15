FactoryGirl.define do
  factory :question,  :class => Refinery::Polls::Question do
    sequence(:title) { |n| "refinery#{n}" }
    start_date  Time.now-10.days
    end_date    Time.now+10.days
  end
  factory :answer,    :class => Refinery::Polls::Answer do
    sequence(:title) { |n| "refinery-answer#{n}" }
    association :question, :factory => :question
  end
  factory :vote,      :class => Refinery::Polls::Vote do
    association :question,  :factory => :question
    association :answer,    :factory => :answer
    sequence(:ip) { |n| "127.0.1.#{n}" }
  end
end

