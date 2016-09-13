require 'support/session_management.rb'

describe FollowsController, '#create' do
  include SessionManagement

  it 'creates a new "follow" Event' do
    follower = login
    followee = create(:user)

    post :create, params: { id: followee.id }

    expect(Event.find_by(user: follower, action: 'follow', subject: followee)).to be_truthy
  end
end

describe FollowsController, '#destroy' do
  include SessionManagement

  it 'deletes the appropriate "follow" event' do
    follower  = login
    followee  = create(:user)
    follow_params = { user: follower, action: 'follow', subject: followee }
    event = create(:event, **follow_params)

    post :destroy, params: { id: followee.id }

    expect(Event.where(follow_params)).to be_empty
  end
end
