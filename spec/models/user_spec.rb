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
  context 'null requirements' do
    it 'require `handle` to not be nil' do
      user = build(:user, handle: '')

      expect(user.valid?).to be_falsey
    end

    it 'require `password` to not be nil' do
      user = build(:user, password: '')

      expect(user.valid?).to be_falsey
    end

    it 'require `name` to not be nil' do
      user = build(:user, name: '')

      expect(user.valid?).to be_falsey
    end
  end


  context 'uniqueness requirements' do
    it 'require `handle` to be unique' do
      first = create(:user, handle: 'faulty')
      second = build(:user, handle: 'faulty')

      expect(second.valid?).to be(false)
    end
  end


  context 'value requirements' do
    it 'require `password` to be 8+ characters long' do
      first = build(:user, password: '1234567')
      second = build(:user, password: '12345678')

      expect(first.valid?).to   be_falsey
      expect(second.valid?).to  be_truthy
    end

    it 'require `handle` to not be blank' do
      user = build(:user, handle: '')

      expect(user.valid?).to be_falsey
    end

    it 'allow `bio` to be blank' do
      user = build(:user, bio: '')

      expect(user.valid?).to be_truthy
    end
  end
end
