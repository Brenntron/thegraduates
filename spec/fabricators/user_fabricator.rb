Fabricator(:user) do
  first_name       { Faker::Name.first_name }
  last_name        { Faker::Name.last_name }
  email            { Faker::Internet.email }
  linkedin         { Faker::Internet.user_name }
  twitter          { Faker::Internet.user_name }
  current_employer { Faker::Company.name }
end
