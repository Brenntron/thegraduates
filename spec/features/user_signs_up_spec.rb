feature "User Signs Up" do

  background do
    visit root_path
    click_on "Sign Up"
  end

  scenario "Happy sign in path" do
    page.should_not have_link("Sign Up")
    fill_in "First name", with: "Edward"
    fill_in "Last name", with: "Norton"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password confirmation", with: "fightclub"
    fill_in "Linkedin", with: Faker::Internet.url("linkedin.com")
    fill_in "Twitter", with: "edward"
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    fill_in "Current employer", with: Faker::Company.name
    click_button "Sign Up"
    page.should have_content("Welcome, Edward!")
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    click_button "Sign In"
    page.should have_content("Welcome back, Edward!")
  end

  scenario "Error Path" do
    fill_in "First name", with: ""
    fill_in "Last name", with: ""
    fill_in "Email", with: "edwardnorton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password confirmation", with: "food"
    fill_in "Linkedin", with: Faker::Internet.user_name
    fill_in "Twitter", with: Faker::Name.first_name
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    fill_in "Current employer", with: Faker::Company.name
    click_button "Sign Up"
    page.should have_alert("Please fix the errors to continue.")

    page.should have_error("can't be blank", on: "First name")
    page.should have_error("can't be blank", on: "Last name")
    page.should have_error("must be an email address", on: "Email")
    page.should have_error("doesn't match Password", on: "Password confirmation")

    fill_in "First name", with: "Edward"
    fill_in "Last name", with: "Norton"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password confirmation", with: "fightclub"
    fill_in "Linkedin", with: Faker::Internet.user_name
    fill_in "Twitter", with: Faker::Name.first_name
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    fill_in "Current employer", with: Faker::Company.name
    click_on "Sign Up"
    page.should have_content("Welcome, Edward!")
  end

  scenario "invalid urls" do
    page.should_not have_link("Sign Up")
    fill_in "First name", with: "Edward"
    fill_in "Last name", with: "Norton"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password confirmation", with: "fightclub"
    fill_in "Linkedin", with: "gobulldyguck"
    fill_in "Twitter", with: "notaur_8973AJOE##*($@()#*()l"
    fill_in "Bio", with: Faker::Lorem.name
    fill_in "Current employer", with: Faker::Company.name
    click_button "Sign Up"
    page.should have_alert("Please fix the errors to continue.")
    fill_in "First name", with: "Edward"
    fill_in "Last name", with: "Norton"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password confirmation", with: "fightclub"
    fill_in "Linkedin", with: Faker::Internet.user_name
    fill_in "Twitter", with: Faker::Name.first_name
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    fill_in "Current employer", with: Faker::Company.name
    click_button "Sign Up"
    page.should have_content("Welcome, Edward!")
  end
end
