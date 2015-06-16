feature "User Signs Up" do

  background do
    visit root_path
    click_on "Sign Up"
  end

  scenario "Happy sign in path" do
    page.should_not have_link("Sign Up")
    fill_in "First Name", with: "Edward"
    fill_in "Last Name", with: "Norton"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password Confirmation", with: "fightclub"
    fill_in "Linkedin", with: "www.linkedin.com/edwardnorton"
    fill_in "Twitter", with: "www.twitter.com/edwardnorton"
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    fill_in "Current Employer", with: Faker::Company.name
    click_button "Sign Up"
    page.should have_content("Welcome Edward!")
    click_on "Sign out"
    click_on "Sign in"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    click_button "Sign In"
    page.should have_content("Welcome back, Edward!")
  end

  scenario "Error Path" do
    fill_in "First Name", with: ""
    fill_in "Last Name", with: ""
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password Confirmation", with: "food"
    fill_in "Linkedin", with: "www.linkedin.com/edwardnorton"
    fill_in "Twitter", with: "www.twitter.com/edwardnorton"
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    fill_in "Current Employer", with: Faker::Company.name
    click_button "Sign Up"
    page.should have_alert("Please fix the errors to continue.")

    page.should have_error("can't be blank", on: "First Name")
    page.should have_error("can't be blank", on: "Last Name")
    page.should have_error("must be an email address", on: "Email")
    page.should have_error("doesn't match Password", on: "Password confirmation")

    fill_in "First Name", with: "Edward"
    fill_in "Last Name", with: "Nrton"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password Confirmation", with: "fightclub"
    fill_in "Linkedin", with: "www.linkedin.com/edwardnorton"
    fill_in "Twitter", with: "www.twitter.com/edwardnorton"
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    fill_in "Current Employer", with: Faker::Company.name
    click_on "Sign Up"
    page.should have_content("Welcome, Edward!")
  end

  scenario "invalid urls" do
    page.should_not have_link("Sign Up")
    fill_in "First Name", with: "Edward"
    fill_in "Last Name", with: "Norton"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password Confirmation", with: "fightclub"
    fill_in "Linkedin", with: "gobulldyguck"
    fill_in "Twitter", with: "notaurl"
    fill_in "Bio", with: Faker::Lorem.name
    fill_in "Current Employer", with: Faker::Company.name
    click_button "Sign Up"
    page.should have_alert("Please fix the errors to continue.")
    fill_in "First Name", with: "Edward"
    fill_in "Last Name", with: "Norton"
    fill_in "Email", with: "edward@norton.com"
    fill_in "Password", with: "fightclub"
    fill_in "Password Confirmation", with: "fightclub"
    fill_in "Linkedin", with: "www.linkedin.com/edwardnorton"
    fill_in "Twitter", with: "www.twitter.com/edwardnorton"
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    fill_in "Current Employer", with: Faker::Company.name
    click_button "Sign Up"
    page.should have_content("Welcome Edward!")
  end
end
