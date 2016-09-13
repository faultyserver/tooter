require 'support/session_management.rb'

describe FavoritesController, '#create' do
  include SessionManagement

  it 'creates a new "favorite" Event' do
    user = login
    toot = create(:toot)

    post :create, params: { id: toot }

    expect(Event.find_by(user: user, action: 'favorite', subject: toot)).to be_truthy
  end

  it 'requires a logged-in user' do
    toot = create(:toot)
    page = post :create, params: { id: toot.id }

    expect_login_request_for(page)
  end
end

describe FavoritesController, '#destroy' do
  include SessionManagement

  it 'deletes the appropriate "favorite" event' do
    user  = login
    toot  = create(:toot)
    favorite_params = { user: user, action: 'favorite', subject: toot }
    event = create(:event, **favorite_params)

    post :destroy, params: { id: toot.id }

    expect(Event.where(favorite_params)).to be_empty
  end

  it 'requires a logged-in user' do
    toot = create(:toot)
    page = post :destroy, params: { id: toot.id }

    expect_login_request_for(page)
  end
end
