require 'support/session_management.rb'

describe FollowsController, '#create' do
  include SessionManagement

  it 'creates a new "follow" Event' do
    follower = login
    followee = create(:user)

    post :create, params: { handle: followee.handle }

    expect(Event.find_by(user: follower, action: 'follow', subject: followee)).to be_truthy
  end

  it 'requires a logged-in user' do
    followee = create(:user)
    page = post :create, params: { handle: followee.handle }

    expect_login_request_for(page)
  end

  it 'does not allow self-following' do
    follower = login

    post :create, params: { handle: follower.handle }

    expect(Event.find_by(user: follower, action: 'follow', subject: follower)).to be_falsey
  end
end

describe FollowsController, '#destroy' do
  include SessionManagement

  it 'deletes the appropriate "follow" event' do
    follower  = login
    followee  = create(:user)
    follow_params = { user: follower, action: 'follow', subject: followee }
    event = create(:event, **follow_params)

    post :destroy, params: { handle: followee.handle }

    expect(Event.where(follow_params)).to be_empty
  end

  it 'requires a logged-in user' do
    followee = create(:user)
    page = post :create, params: { handle: followee.handle }

    expect_login_request_for(page)
  end
end
