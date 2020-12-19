FactoryBot.define do
  factory :user do
    sequence(:name) { "tester"}
    sequence(:email) { "test@example.com"}
    sequence(:password) { "password"}
    sequence(:password_confirmation) { "password"}
    sequence(:profile) { "はじめまして！"}
  end

  factory :testuser, class: User do
    sequence(:name) { "tester02"}
    sequence(:email) { "test02@example.com"}
    sequence(:password) { "password02"}
    sequence(:password_confirmation) { "password02"}
    sequence(:profile) { ""}
  end

end