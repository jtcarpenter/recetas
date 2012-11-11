RSpec::Matchers.define :require_login do
  match do |actual|
    #redirect_to Rails.application.routes.url_helpers.login_path
    redirect_to Rails.application.routes.url_helpers.new_user_session_path 
  end
  failure_message_for_should do |actual|
    "expected to require login to access this method"
  end
  failure_message_for_should_not do |actual|
    "expected not to require login to access this method"
  end
  description do 
    "redirect to the login form"
  end
end