FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.free_email }
    password { '123456abc' }
    password_confirmation { password }
  end
end
