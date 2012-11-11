describe 'user management' do
  it "adds a new user" do
    admin = create(:admin)

    visit new_user_session_path
    fill_in 'user[email]', with: admin.email
    fill_in 'user[password]', with: admin.password
    click_button 'sign_in'

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
end