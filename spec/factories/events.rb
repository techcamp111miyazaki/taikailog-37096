FactoryBot.define do
  factory :event do
    event_title { Faker::Name.name }
    place { Faker::Name.name }
    prefecture_id { Faker::Number.between(from:2, to:48) }
    genre_id { Faker::Number.between(from:2, to:16) }
    date { Faker::Date.between(from: 5.days.ago, to: Date.today) }

    association :user

    after(:build) do |event|
      event.image.attach(io: File.open('public/images/image.png'), filename: 'image.png')
    end
  end
end
