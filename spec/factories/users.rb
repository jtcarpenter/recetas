require 'faker'

FactoryGirl.define do
  factory :user do
    email {Faker::internet.email}
    password {Faker::name.name}
    password_confirmation {Faker::name.name}

    factory :invalid_user do
      email nil
    end
  end
end