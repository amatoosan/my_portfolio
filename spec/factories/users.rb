FactoryBot.define do
  factory :user do
    sequence(:name) { "tester"}
    sequence(:email) { "test@example.com"}
  end
end