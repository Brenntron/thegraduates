RSpec::Matchers.define :have_no_errors_on do |field_name|
  match do |page|
    assert !page.find_field(field_name).find(:xpath, "..").has_css?("span.error")
  end
end

RSpec::Matchers.define :have_error do |expected, options|
  match do |page|
    page.find_field(options[:on]).parent.should have_css("span.error", text: expected)
  end
end

RSpec::Matchers.define :have_alert do |expected, options|
  match do |page|
    page.should have_css('.flash-alert', text: expected)
  end
end

RSpec::Matchers.define :have_notice do |expected, options|
  match do |page|
    page.should have_css('.flash-notice', text: expected)
  end
end

def should_be_denied_access
  current_path.should == root_path
  page.should have_alert("You do not have permission to access that page.")
end
