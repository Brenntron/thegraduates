feature "List only has PER_PAGE numbers of items in a list per page." do
  scenario "user index onlu has 5 users per page" do
    me = Fabricate(:user)
    14.times do
      Fabricate(:user)
    end
    signin_as me
    page.should have_css('ul.user_pagination')
    within('ul.user_pagination') do
      page.should have_css('li:nth-child(4)')
      page.should have_css('li:nth-child(5)')
      page.should_not have_css('li:nth-child(6)')
    end
    click_link "2"
    within('ul.user_pagination') do
      page.should have_css('li:nth-child(4)')
      page.should have_css('li:nth-child(5)')
      page.should_not have_css('li:nth-child(6)')
    end
  end
end
