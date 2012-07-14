
FactoryGirl.define do
  factory :question, :class => Refinery::Polls::Question do
    sequence(:title) { |n| "refinery#{n}" }
  end
  factory :answer, :class => Refinery::Polls::Answer do
    sequence(:title) { |n| "refinery-answer#{n}" }
    question  nil
  end
end

