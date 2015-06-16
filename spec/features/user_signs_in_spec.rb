feature "user signs in" do

  before do
    visit "/"
    click_on "Sign In"
    page.should_not have_link("Sign In")
  end

  scenario "Returning user signs in" do
    user = Fabricate(:user, name: "Jan")
    fill_in "Email", with: user.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    page.shoudl have_content("Welcome back, Jan")
    page.should_not have_content("Sign In")
    page.should_not have_content("Sign Up")
    page.should have_content("Sign Out")
    click_on "Sign Out"
    page.should have_content("You have been signed out")
    page.should have_content("Sign In")
    page.should_not have_content("Sign Out")
  end

  scenario "returning user attempts to sign in with incorrect password" do
    user = Fabricate(:user, name: "Bob")
    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpassword"
    click_button "Sign In"
    page.should have_content("We could not sign you in. Please check your email/password and try again.")
    page.should_not have_content("Create your account")
    page.should_not have_content("Password confirmation")
    field_labeled("Email").value.should == user.email
    fill_in "Password", with: "password1"
    click_button "Sign In"
    page.should have_content("Welcome back, Bob!")
  end

  scenario "user signs in with wrong email" do
    Fabricate(:user, email: "jimbo@example.com", password: "Awesomeness", password_confirmation: "Awesomeness")
    fill_in "Email", with: "bobbie@example.com"
    fill_in "Password", with: "Awesomeness"
    click_on "Sign In"
    page.should have_content("We could not sign you in. Please check your email/password and try again.")
  end

  scenario "user signs in with blanks" do
    click_on "Sign In"
    page.should have_content("We could not sign up in. Please check you email/password and try again.")
  end
end
