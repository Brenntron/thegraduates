Fabricator(:user) do
  first_name            { Faker::Name.first_name }
  last_name             { Faker::Name.last_name }
  email                 { Faker::Internet.email }
  linkedin              { Faker::Internet.user_name }
  twitter               { Faker::Name.first_name.downcase }
  current_employer      { Faker::Company.name }
  cohort                { Faker::Number.digit }
  graduation_date       { Faker::Time.between(2.years.ago, Date.today) }
  bio                   { Faker::Lorem.paragraph(2) }
  password              { "password1" }
  password_confirmation { "password1" }
end
