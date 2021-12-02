FactoryBot.define do
  factory :match do
    turn_id { Faker::Number.between(from:2, to:14) }
    field_id { Faker::Number.between(from:2, to:14) }
    order_number {Faker::Number.non_zero_digit}
    player_name_1 { Faker::Name.name }
    belongs_1 { Faker::University.name }
    score_1 { Faker::Number.non_zero_digit}
    player_name_2 { Faker::Name.name }
    belongs_2 { Faker::University.name }
    score_2 { Faker::Number.non_zero_digit}
    log { Faker::Lorem.word }

    association :user
    association :event

  end
end
