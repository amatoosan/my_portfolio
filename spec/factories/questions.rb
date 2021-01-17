FactoryBot.define do
  factory :question do
    title { "TestQuestions-1" }
    content { "Question!" }
    created_at { 10.minutes.ago }
    association :user

    trait :yesterday do
      title { "TestQuestions-2" }
      content { "yesterday" }
      created_at { 1.day.ago }
    end

    trait :day_before_yesterday do
      title { "TestQuestions-3" }
      content { "day_before_yesterday" }
      created_at { 2.days.ago }
    end

    trait :now do
      title { "TestQuestions-4" }
      content { "now!" }
      created_at { Time.zone.now }
    end
  end
end
