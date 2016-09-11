describe Favorite do
  it 'belongs to a Toot' do
    favorite = create(:favorite)

    expect(favorite.toot).to be_a(Toot)
  end

  it 'belongs to a User' do
    expect(favorite.user).to be_a(User)
  end

  it 'has a non-nil creation date' do
    expect(favorite.created_at).not_to be(nil)
  end
end
