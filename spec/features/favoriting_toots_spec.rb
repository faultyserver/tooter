require 'support/features/session_helpers.rb'

feature 'Favoriting/Unfavoriting Toots' do
  include Features::SessionHelpers

  let!(:toot) { create(:toot) }
  let!(:user) { create(:user) }

  scenario 'while not signed in' do
    visit root_path
    attempt_favorite(toot)

    expect_sign_in_request
  end

  context 'while signed in' do
    before(:each) do
      sign_in_as user.handle, user.password
    end

    scenario 'without an existing favorite' do
      visit user_path(toot.author)
      attempt_favorite(toot)

      expect_favorited(toot)
    end

    scenario 'with an existing favorite' do
      visit user_path(toot.author)
      attempt_favorite(toot)

      # Favorite should act like a toggle: clicking the button again should
      # unfavorite the toot.
      attempt_favorite(toot)

      expect_unfavorited(toot)
    end
  end


  def attempt_favorite toot
    find_by_id("toot-#{toot.id}").find("a[value=favorite]").click
  end

  def expect_favorited toot
    favorite_count = find_by_id("toot-#{toot.id}").find('.toot-favorite-count').text
    expect(favorite_count).to eq('1')
  end

  def expect_unfavorited toot
    favorite_count = find_by_id("toot-#{toot.id}").find('.toot-favorite-count').text
    expect(favorite_count).to eq('0')
  end
end
