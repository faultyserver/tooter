describe User, 'authentication' do
  it 'does not store plaintext passwords' do
    # Create a user, then find its record to see what's stored in the database
    created_user = create(:user)
    stored_user = User.find(created_user.id)

    expect(stored_user.password).to be(nil)
    expect(stored_user.password_digest).not_to be(created_user.password)
  end

  it 'can authenticate users via their plaintext password' do
    user = create(:user)

    expect(user.authenticate(user.password)).to be_truthy
  end

  it 'does not authenticate users with incorrect passwords' do
    user = create(:user, password: 'test_password1')

    expect(user.authenticate('test_password2')).to be_falsey
  end
end


describe User, 'associations' do
  context 'toots' do
    it 'can be the `author` of many toots' do
      user = create(:user)
      toots = create_list(:toot, 5, author: user)

      expect(user.toots).to match_array(toots)
    end

    it 'is normally ordered from newest to oldest' do
      user = create(:user)
      toot1 = create(:toot, author: user)
      toot2 = create(:toot, author: user)

      expect(user.toots).to eq([toot2, toot1])
    end

    it 'can be empty' do
      user = create(:user)

      expect(user.toots).to be_empty
    end
  end
end


describe User, 'validations' do
  context '#handle' do
    it 'must not be nil' do
      user = build(:user, handle: nil)

      expect(user.valid?).to be_falsey
    end

    it 'must not be blank' do
      user = build(:user, handle: '')

      expect(user.valid?).to be_falsey
    end

    it 'must be less than 32 characters long' do
      user = build(:user, handle: 'a'*33)

      expect(user.valid?).to be_falsey
    end

    it 'must be unique' do
      first = create(:user, handle: 'faulty')
      second = build(:user, handle: 'faulty')

      expect(second.valid?).to be_falsey
    end

    it 'must not contain spaces' do
      user = build(:user, handle: 'bad handle')

      expect(user.valid?).to be_falsey
    end

    it 'may contain underscores' do
      user = build(:user, handle: 'good_handle')

      expect(user.valid?).to be_truthy
    end
  end

  context '#password' do
    it 'must not be nil' do
      user = build(:user, password: nil)

      expect(user.valid?).to be_falsey
    end

    it 'must be at least 8 characters long' do
      first = build(:user, password: '1234567')
      second = build(:user, password: '12345678')

      expect(first.valid?).to   be_falsey
      expect(second.valid?).to  be_truthy
    end
  end

  context '#name' do
    it 'must not be nil' do
      user = build(:user, name: nil)

      expect(user.valid?).to be_falsey
    end

    it 'must not be blank' do
      user = build(:user, name: '')

      expect(user.valid?).to be_falsey
    end

    it 'must be less than 64 characters long' do
      user = build(:user, name: 'a'*65)

      expect(user.valid?).to be_falsey
    end
  end

  context '#bio' do
    it 'may be assigned nil' do
      user = build(:user, bio: nil)

      expect(user.valid?).to be_truthy
    end

    it 'may be left blank' do
      user = build(:user, bio: '')

      expect(user.valid?).to be_truthy
    end

    it 'must be less than 200 characters long' do
      user = build(:user, bio: 'a'*201)

      expect(user.valid?).to be_falsey
    end
  end
end


describe User, '#event_stream' do
  it 'includes toot events by the user' do
    user  = create(:user)
    event = create(:toot_event, user: user)

    expect(user.event_stream).to include(event)
  end

  it 'includes favorite events by the user' do
    user  = create(:user)
    event = create(:favorite_event, user: user)

    expect(user.event_stream).to include(event)
  end

  it 'does not include Events the user did not initiate' do
    user1  = create(:user)
    user2  = create(:user)
    event = create(:event, user: user1, subject: user2)

    expect(user2.event_stream).to be_empty
  end

  it 'is ordered by creation date' do
    user    = create(:user)
    event1  = create(:event, user: user)
    event2  = create(:event, user: user)

    expect(user.event_stream).to eq([event2, event1])
  end
end
