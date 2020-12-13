FactoryBot.define do
  factory :user do
    sequence(:name) { "tester"}
    sequence(:email) { "test@example.com"}
    sequence(:password) { "password"}
    sequence(:password_confirmation) { "password"}
    sequence(:profile) { "はじめまして！"}
  end
end