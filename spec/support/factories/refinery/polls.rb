
FactoryGirl.define do
  factory :question, :class => Refinery::Polls::Question do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

