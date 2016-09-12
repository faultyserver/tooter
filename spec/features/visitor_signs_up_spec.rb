feature 'Visitor signs up' do
  scenario 'with valid credentials' do
    attempt_sign_up_with # defaults
    expect_sign_up_success
  end

  scenario 'with a blank handle' do
    attempt_sign_up_with handle: ''
    expect_sign_up_failure
  end

  scenario 'with a blank password' do
    attempt_sign_up_with password: ''
    expect_sign_up_failure
  end

  scenario 'with a blank name' do
    attempt_sign_up_with name: ''
    expect_sign_up_failure
  end

  scenario 'with a blank bio' do
    attempt_sign_up_with bio: ''
    expect_sign_up_failure
  end

  scenario 'with a handle that is too long' do
    # Handles are limited to 32 characters
    attempt_sign_up_with handle: 'a'*33
    expect_sign_up_failure
  end

  scenario 'with a name that is too long' do
    # Names are limited to 255 characters
    attempt_sign_up_with name: 'a'*256
    expect_sign_up_failure
  end

  scenario 'with a password that is too short' do
    attempt_sign_up_with password: '1234567'
    expect_sign_up_failure
  end

  scenario 'with a bio that is too long' do
    # Bios are limited to 200 characters
    attempt_sign_up_with bio: 'a'*201
    expect_sign_up_failure
  end



  def attempt_sign_up_with handle: 'faultyserver', password: 'password', name: 'Jon', bio: ''
    visit sign_up_path
    fill_in 'Handle',   with: handle
    fill_in 'Password', with: password
    fill_in 'Name',     with: name
    fill_in 'Bio',      with: bio
    click_button 'Sign Up!'
  end

  def expect_sign_up_success
    expect(page).to have_content('Logout')
  end

  def expect_sign_up_failure
    expect(page).to have_content('Sign Up')
  end
end
