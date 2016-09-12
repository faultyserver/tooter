require 'support/features/session_helpers.rb'

feature 'Posting toots' do
  include Features::SessionHelpers

  let(:toot_body) { 'toot toot.' }

  scenario 'while not signed in' do
    visit new_toot_path
    expect_sign_in_request
  end

  context 'while signed in' do
    before(:each) do
      @user = create(:user)
      sign_in_as @user.handle, @user.password
    end

    scenario 'with a valid body' do
      attempt_toot body: toot_body
      expect_toot_success
    end

    scenario 'with a blank body' do
      attempt_toot body: ''
      expect_toot_failure
    end
  end


  def attempt_toot body:
    visit new_toot_path
    fill_in 'toot_body', with: body
    click_button 'Create Toot'
  end

  def expect_toot_failure
    expect(page).to have_content('can\'t be blank')
  end

  def expect_toot_success
    expect(page).to have_content(@user.handle)
    expect(page).to have_content(toot_body)
  end
end
