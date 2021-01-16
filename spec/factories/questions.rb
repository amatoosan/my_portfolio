FactoryBot.define do
  factory :question do
    title { "Test Questions" }
    content { "MyText" }
    association :user
  end
end
