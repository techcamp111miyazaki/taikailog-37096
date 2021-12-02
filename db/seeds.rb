2.times do |n|
  User.create!(
    name:  "管理者#{n + 1}",
    email: "admin#{n + 1}@admin#{n + 1}.com",
    password:  "admin#{n + 1}",
    password_confirmation: "admin#{n + 1}",
    admin: true
  )
end

10.times do |n|
  User.create!(
    name:  "ユーザー#{n + 1}",
    email: "sample#{n + 1}@sample#{n + 1}.com",
    password:  "sample#{n + 1}",
    password_confirmation: "sample#{n + 1}",
  )
end