feature "user signs in" do

  before do
    visit rails_admin
    fill_in "Email", with: "brennan@w.com"
    fill_in "Password", with: "notpassword1"
    click_on "Sign In"
  end
end
