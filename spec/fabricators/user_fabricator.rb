Fabricator(:user) do
  first_name            { Faker::Name.first_name }
  last_name             { Faker::Name.last_name }
  email                 { Faker::Internet.email }
  linkedin              { Faker::Internet.url("linkedin.com") }
  twitter               { Faker::Internet.url("twitter.com") }
  current_employer      { Faker::Company.name }
  bio                   { Faker::Lorem.paragraph(2) }
  password              { "password1" }
  password_confirmation { "password1" }
end
