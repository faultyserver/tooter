describe Event do
  it 'belongs to a User' do
    event = create(:event)
    expect(event.user).to be_a(User)
  end

  it 'can have a Toot subject' do
    event = create(:toot_event)
    expect(event.subject).to be_a(Toot)
  end

  it 'has a descriptive action' do
    toot_event = create(:toot_event)
    favorite_event = create(:favorite_event)

    expect(toot_event.action).to eq('toot')
    expect(favorite_event.action).to eq('favorite')
  end
end


describe Event, '.stream_for_user' do
  it 'does not include events initiated by the user' do
    user = create(:user)
    events = create_list(:event, 5, user: user)

    expect(Event.stream_for_user(user)).to be_empty
  end

  it 'includes events for which the User is a subject' do
    user = create(:user)
    events = create_list(:event, 5, subject: user)

    expect(Event.stream_for_user(user)).to match_array(events)
  end

  it 'includes events for which the User is not the initiator' do
    user1 = create(:user)
    user2 = create(:user)
    events = create_list(:event, 5, user: user1, subject: user2)

    expect(Event.stream_for_user(user2)).to match_array(events)
  end

  it 'includes events initiated by another user that the user follows' do
    user1 = create(:user)
    user2 = create(:user)
    # user1 follows user2
    create(:event, user: user1, action: 'follow', subject: user2)
    event = create(:toot_event, user: user2)

    expect(Event.stream_for_user(user1)).to include(event)
  end

  it 'only contains distinct events (no duplicates)' do
    user = create(:user)
    event = create(:event, user: user, subject: user)

    expect(Event.stream_for_user(user).length).to be(1)
  end

  it 'does not include events not involving the User' do
    user1 = create(:user)
    user2 = create(:user)
    events = create_list(:event, 5, user: user1)

    expect(Event.stream_for_user(user2)).to be_empty
  end
end
