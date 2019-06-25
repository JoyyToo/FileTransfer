FactoryBot.define do
  factory :document, class: Document do
    name { Faker::Name.name }
  end
end
