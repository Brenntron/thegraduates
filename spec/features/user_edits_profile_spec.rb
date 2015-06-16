feature "user edits profile" do

  let(:brennan){ Fabricate(:user, name: "Brennan") }
  let(:jimbob){ Fabricate(:user, name: "Jimbob") }

  scenario "can't edit profile if logged out" do
    pending
    visit users_path(brennan)
  end
end
