require 'support/session_management.rb'

describe TootsController, '#create' do
  include SessionManagement

  let(:toot_body) { 'Test toot' }

  it 'requires a logged-in user' do
    page = post :create, params: { body: toot_body }

    expect_login_request_for(page)
  end


  context 'while signed in' do
    before :each do
      @user = login
    end

    subject!{ post :create, params: { toot: { body: toot_body } } }

    context 'with valid data' do
      it 'creates a new Toot record' do
        expect(Toot.find_by(body: toot_body)).to be_truthy
      end

      it 'creates a new "toot" Event' do
        expect(Event.where(user: @user, action: 'toot').count).to eq(1)
      end
    end
  end
end

describe TootsController, '#destroy' do
  include SessionManagement

  let!(:toot) { create(:toot) }

  it 'requires a logged-in user' do
    page = post :destroy, params: { id: toot.id }

    expect_login_request_for(page)
  end


  context 'while signed in' do
    before :each do
      @user = login
    end

    subject!{ post :destroy, params: { id: toot.id } }

    context 'with valid data' do
      it 'removes the appropriate Toot record' do
        expect(Toot.where(body: toot.body)).to be_empty
      end

      it 'removes the appropriate "toot" Event' do
        expect(Event.where(user: @user, action: 'toot', subject: toot.id)).to be_empty
      end
    end
  end
end
