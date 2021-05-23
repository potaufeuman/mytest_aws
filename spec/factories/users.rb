FactoryBot.define do
  factory :user do
    name { "Example" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    activated { true }
    admin { false }
  end
end
