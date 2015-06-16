feature "user edits profile" do

  let(:brennan){ Fabricate(:user, name: "Brennan") }
  let(:jimbob){ Fabricate(:user, name: "Jimbob") }

  scenario "can't edit profile if logged out" do
    visit users_path(brennan)
    page.should_not have_link("Edit")
    visit "/user/edit"
    current_path.should == root_path
  end

  scenario "different user con't edit profile" do
  visti "/"
  click_on "Sign In"
  fill_in "Email", with: brennan.email
  fill_in "Password", with: brennan.password
  click_button "Sign In"
  visit users_path(jimbob)
  end

  scenario "edit user profile sad path" do
    visit "/"
    click_on "Sign In"
    fill_in "Email", with: brennan.email
    fill_in "Password", with: brennan.password
    click_button "Sign In"
    click_on "Brennan"
    click_on "Edit"
    fill_in "First Name", with: "Brennan"
    fill_in "Last Name", with: "Willingham"
    fill_in "Email", with: ""
    fill_in "Bio", with: Faker::Lorem.paragraph(2)
    click_on "Save Changes"
    page.should have_css(".flash-alert", text: "Please fix the errors to continue.")
    field_labeled("First Name").value.should == "Brennan"
    field_labeled("Last Name").value.should == "Willingham"
    field_labeled("Email").value.should == ""
    page.should have_css(".email .error", test: "can't be blank")
  end
end
