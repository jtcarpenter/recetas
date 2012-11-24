require 'faker'

FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    name "name"
    password "password"
    password_confirmation "password"
    admin false

    factory :admin do
      email {Faker::Internet.email}
      name "name"
      password "password"
      password_confirmation "password"
      admin true
    end

    factory :invalid_user do
      email nil
    end
  end
end