require 'faker'

FactoryGirl.define do
  factory :post do
    title "test title"
    summary {Faker::Lorem.paragraphs(paragraph_count = 1, supplemental = false)}
    ingredients {Faker::Lorem.paragraph(paragraph_count = 3)}
    instructions {Faker::Lorem.paragraph(paragraph_count = 3)}
    published true
    tag_list "tag1, tag2, tag3, tag4, tag5"

    factory :invalid_post do
      title nil
    end
  end
end