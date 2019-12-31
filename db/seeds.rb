User.create!(
    name:  "John Doe",
    email: "john@example.com",
    password:"adminpass",
    password_confirmation: "adminpass",
    admin: true,
    activated: true,
    activated_at: Time.zone.now
)

99.times do |n|
    name  = Faker::Name.name
    email = Faker::Internet.email
    password = "password"
    User.create!(
      name:  name,
      email: email,
      password: password,
      password_confirmation: password,
      activated: true,
      activated_at: Time.zone.now
    )
end
