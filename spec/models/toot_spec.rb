describe Toot, 'associations' do
  context 'author' do
    it 'must not be nil' do
      toot = build(:toot, author: nil)

      expect(toot.valid?).to be_falsey
    end
  end
end

describe Toot, 'validations' do
  it 'require `body` to not be nil' do
    toot = build(:toot, body: nil)

    expect(toot.valid?).to be_falsey
  end

  it 'require `body` to not be blank' do
    toot = build(:toot, body: '')

    expect(toot.valid?).to be_falsey
  end
end
