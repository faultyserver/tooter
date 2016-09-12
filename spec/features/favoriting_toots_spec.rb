require 'support/features/session_helpers.rb'

feature 'Favoriting/Unfavoriting Toots' do
  include Features::SessionHelpers

  let(:toot) { create(:toot) }
  let(:user) { create(:user) }

  scenario 'while not signed in' do
    visit toots_path
    attempt_favorite(toot)

    expect_sign_in_request
  end

  context 'while signed in' do
    before(:each) do
      sign_in_as user.handle, user.password
    end

    scenario 'without an existing favorite' do
      visit toots_path
      attempt_favorite(toot)

      expect_favorited(toot)
    end

    scenario 'with an existing favorite' do
      visit toots_path
      attempt_favorite(toot)

      # Favorite should act like a toggle: clicking the button again should
      # unfavorite the toot.
      attempt_favorite(toot)

      expect_unfavorited(toot)
    end
  end


  def attempt_favorite toot
    within("#toot-#{toot.id}") do
      find("button[value=favorite]").click
    end
  end

  def expect_favorited toot
    expect(page).to have_css("#toot-#{toot.id} .favorited")
  end

  def expect_unfavorited toot
  end
end
