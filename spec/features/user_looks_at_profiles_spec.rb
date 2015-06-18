feature "User views profiles" do

  scenario "viewing a profile when not signed in." do
    Fabricate(:user, first_name: "Brennan", last_name: "Willingham", password: "password1", password_confirmation: "password1")
    visit root_path
    page.should have_link("Willingham, Brennan")
    click_on ("Willingham, Brennan")
    page.should have_css(".name", text: "Brennan Willingham")
    page.should have_css(".bio")
  end
end
