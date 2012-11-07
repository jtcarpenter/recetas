require 'faker'

FactoryGirl.define do
  factory :post do
    title "test title"
    summary {Faker::Lorem.paragraphs(paragraph_count = 3, supplemental = false)}
    published true

    factory :invalid_post do
      title nil
    end
  end
end