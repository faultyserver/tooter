require 'support/features/session_helpers.rb'

feature 'Following/Unfollowing Users' do
  include Features::SessionHelpers

  let!(:follower) { create(:user) }
  let!(:followee) { create(:user) }

  scenario 'while not signed in' do
    attempt_follow

    expect_sign_in_request
  end

  context 'while signed in' do
    before(:each) do
      sign_in_as follower.handle, follower.password
    end

    scenario 'and not currently following' do
      attempt_follow

      expect_following
    end

    scenario 'and currently following' do
      attempt_follow
      attempt_unfollow

      expect_not_following
    end
  end


  def attempt_follow
    visit user_path(followee)
    click_link('Follow')
  end

  def attempt_unfollow
    visit user_path(followee)
    click_link('Unfollow')
  end

  def expect_following
    expect(page).to have_selector(:link_or_button, 'Unfollow')
  end

  def expect_not_following
    expect(page).to have_selector(:link_or_button, 'Follow')
  end
end
