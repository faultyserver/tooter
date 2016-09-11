describe SessionsController do
  describe 'GET /login' do
    subject { get :new }

    it 'renders the session login form' do
      expect(subject).to render_template(:new)
    end
  end


  describe 'POST /login' do
    let(:user) { create(:user) }


    context 'with valid login credentials' do
      let(:user_params) { { user: { handle: user.handle, password: user.password } } }
      subject { post :create, params: user_params }


      it 'redirects to the home page' do
        expect(subject).to redirect_to(root_path)
      end

      it 'sets a session variable with the user id' do
        expect(session[:user_id]).to eq(user.id)
      end
    end


    context 'with invalid login credentials' do
      let(:user_params) { { user: { handle: user.handle, password: '' } } }
      subject { post :create, params: user_params}


      it 'redirects to the login page' do
        expect(subject).to redirect_to(login_path)
      end

      it 'does not set the `user_id` session variable' do
        expect(session[:user_id]).to be(nil)
      end
    end
  end


  describe 'GET /logout' do
    subject { get :destroy, session: { user_id: 10 } }

    it 'unsets the `user_id` session variable' do
      expect(session[:user_id]).to be(nil)
    end

    it 'redirects to the home page' do
      expect(subject).to redirect_to(root_path)
    end
  end
end
