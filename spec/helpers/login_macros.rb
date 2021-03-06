module LoginMacros
  def sign_in(user)
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'sign_in'
  end
  def sign_out(user)
    click_link 'sign_out'
  end
end