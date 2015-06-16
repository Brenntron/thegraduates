feature "User Signs Up" do

  background do
    visit root_path
    click_on "Sign Up"
    joe = Fabricate(:user)
  end

  scenario "Happy sign in path" do
    page.should_not have_link("Sign Up")
    fill_in "First Name", with: "#{joe.first_name}"
    fill_in "Last Name", with: "#{joe.last_name}"
    fill_in "Email", with: "#{joe.email}"
    fill_in "Password", with: "#{joe.password}"
    fill_in "Password Confirmation", with: "#{joe.password_confirmation}"
    fill_in "Linkedin", with: "#{joe.linkedin}"
    fill_in "Twitter", with: "#{joe.twitter}"
    fill_in "Bio", with: "#{joe.bio}"
    fill_in "Current Employer", with: "#{joe.current_employer}"
    click_button "Sign Up"
    page.should have_content("Welcome #{joe.first_name}!")
    click_on "Sign out"
    click_on "Sign in"
    fill_in "Email", with: "#{joe.email}"
    fill_in "Password", with: "#{joe.password}"
    click_button "Sign In"
    page.should have_content("Welcome back, #{joe.first_name}!")
  end

  scenario "Error Path" do
    fill_in "First Name", with: ""
    fill_in "Last Name", with: ""
    fill_in "Email", with: "#{joe.email}"
    fill_in "Password", with: "#{joe.password}"
    fill_in "Password Confirmation", with: "food"
    fill_in "Linkedin", with: "#{joe.linkedin}"
    fill_in "Twitter", with: "#{joe.twitter}"
    fill_in "Bio", with: "#{joe.bio}"
    fill_in "Current Employer", with: "#{joe.current_employer}"
    click_button "Sign Up"
    page.should have_alert("Please fix the errors to continue.")

    page.should have_error("can't be blank", on: "First Name")
    page.should have_error("can't be blank", on: "Last Name")
    page.should have_error("must be an email address", on: "Email")
    page.should have_error("doesn't match Password", on: "Password confirmation")

    fill_in "First Name", with: "#{joe.first_name}"
    fill_in "Last Name", with: "#{joe.last_name}"
    fill_in "Email", with: "#{joe.email}"
    fill_in "Password", with: "#{joe.password}"
    fill_in "Password Confirmation", with: "#{joe.password_confirmation}"
    fill_in "Linkedin", with: "#{joe.linkedin}"
    fill_in "Twitter", with: "#{joe.twitter}"
    fill_in "Bio", with: "#{joe.bio}"
    fill_in "Current Employer", with: "#{joe.current_employer}"
    click_on "Sign Up"
    page.should have_content("Welcome, #{joe.first_name}!")
  end

  scenario "invalid urls" do
    page.should_not have_link("Sign Up")
    fill_in "First Name", with: "#{joe.first_name}"
    fill_in "Last Name", with: "#{joe.last_name}"
    fill_in "Email", with: "#{joe.email}"
    fill_in "Password", with: "#{joe.password}"
    fill_in "Password Confirmation", with: "#{joe.password_confirmation}"
    fill_in "Linkedin", with: "gobulldyguck"
    fill_in "Twitter", with: "notaurl"
    fill_in "Bio", with: "#{joe.bio}"
    fill_in "Current Employer", with: "#{joe.current_employer}"
    click_button "Sign Up"
    page.should have_alert("Please fix the errors to continue.")
    fill_in "First Name", with: "#{joe.first_name}"
    fill_in "Last Name", with: "#{joe.last_name}"
    fill_in "Email", with: "#{joe.email}"
    fill_in "Password", with: "#{joe.password}"
    fill_in "Password Confirmation", with: "#{joe.password_confirmation}"
    fill_in "Linkedin", with: "#{joe.linkedin}"
    fill_in "Twitter", with: "#{joe.twitter}"
    fill_in "Bio", with: "#{joe.bio}"
    fill_in "Current Employer", with: "#{joe.current_employer}"
    click_button "Sign Up"
    page.should have_content("Welcome #{joe.first_name}!")
  end
end
