describe 'user management' do
  before :each do
    @admin = create(:admin)
    sign_in @admin
  end
  it "adds a new user" do
    expect {
      click_link 'new_user_link'
      fill_in 'user[email]', with: 'mail@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'create_user'
    }.to change(User, :count).by(1)
    current_path.should eq users_path
    page.should have_content 'mail@example.com'
    # Saves last page and opens in browser, for debugging
    # save_and_open_page
  end
  #-------------------------------
  # Uncomment to run selenium test
  #-------------------------------
  #it "deletes a user", js: true do
  it "deletes a user" do
    user = create(:user, email:"temp@example.com", password: "password", password_confirmation: "password")
    visit users_path
    expect {
      within "#user_#{user.id}" do
        click_link "destroy"
      end
      #alert = page.driver.browser.switch_to.alert
      #alert.accept
    }.to change(User, :count).by(-1)
    page.should_not have_content "temp@example.com"
  end

  it "sends a forgottem password link" do
    sign_out @admin
    # might have to create new user with specific email
    visit new_user_session_path
    click_link "forgotten_password"
    fill_in 'user[email]', with: @admin.email
    click_button 'send'
    #open_last_email.should be_delivered_from sender.email
    #open_last_email.should have_reply_to sender.email
    open_last_email.should be_delivered_to @admin.email
    #open_last_email.should have_subject message.subject
    #open_last_email.should have_body_text message.message
  end
end