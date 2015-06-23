feature "user edits profile" do

  let(:brennan){ Fabricate(:user, first_name: "Brennan", last_name: "Willingham", password: "password1", password_confirmation: "password1", twitter: "brennan") }
  let(:jimbob){ Fabricate(:user, first_name: "Jimbob", last_name: "Thorne", twitter: "jimbob") }

  scenario "can't edit profile if logged out" do
    visit user_path(brennan)
    page.should_not have_link("Edit Profile")
    visit edit_user_registration_path
    current_path.should == root_path
  end

  scenario "different user con't edit profile" do
  visit root_path
  click_on "Sign In"
  fill_in "Email", with: brennan.email
  fill_in "Password", with: brennan.password
  click_button "Sign In"
  visit user_path(jimbob)
  page.should_not have_link("Edit Profile")
  end

  scenario "edit user profile sad path" do
    visit root_path
    click_on "Sign In"
    fill_in "Email", with: "#{brennan.email}"
    fill_in "Password", with: "password1"
    click_on "Sign In"
    click_on "Willingham, Brennan"
    click_on "Edit Profile"
    fill_in "First name", with: "Brennan"
    fill_in "Last name", with: "Willingham"
    fill_in "Email", with: ""
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    click_on "Save Changes"
    page.should have_css(".flash-alert", text: "Please fix the errors to continue.")
    field_labeled("First name").value.should == "Brennan"
    field_labeled("Last name").value.should == "Willingham"
    field_labeled("Email").value.should == ""
    page.should have_css(".email .error", text: "can't be blank")
  end
end
