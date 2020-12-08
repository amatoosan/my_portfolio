FactoryBot.define do
  factory :user do
    sequence(:name) { "tester"}
    sequence(:email) { "test@example.com"}
    sequence(:password) { "foobar"}
    sequence(:password_confirmation) { "foobar"}
  end
end