describe 'user management' do

  #-------------------------------
  # Set to true run selenium tests
  #-------------------------------
  selenium = false;

  before :each do
    @selenium = selenium ? true : false
    @admin = create(:admin)
    sign_in @admin
  end

  it "adds a new user" do
    expect {
      click_link 'new_user_link'
      fill_in 'user[email]', with: 'mail@example.com'
      fill_in 'user[name]', with: 'name'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'create_user'
    }.to change(User, :count).by(1)
    current_path.should eq users_path
    page.should have_content 'mail@example.com'
    # Saves last page and opens in browser, for debugging
    # save_and_open_page
  end
  
  it "deletes a user", js: selenium do
    user = create(:user, email: "temp@example.com", password: "password", password_confirmation: "password")
    visit users_path
    expect {
      within "#user_#{user.id}" do
        click_link "destroy"
      end
      if (@selenium)
        alert = page.driver.browser.switch_to.alert
        alert.accept
      end
    }.to change(User, :count).by(-1)
    page.should_not have_content "temp@example.com"
  end

  it "sends a forgottem password link to", js: selenium do
    user = create(:user)
    sign_out @admin
    visit new_user_session_path
    click_link "forgotten_password"
    fill_in 'user[email]', with: user.email
    click_button 'send'
    current_path.should eq new_user_session_path
    page.should have_content(I18n.t("devise.passwords.send_instructions"))
    open_last_email.should be_delivered_to user.email
    open_last_email.should have_subject I18n.t("devise.mailer.reset_password_instructions.subject")
  end
end