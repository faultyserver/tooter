module Features
  module SessionHelpers
    def sign_in_as handle, password
      visit login_path
      fill_in 'Handle',   with: handle
      fill_in 'Password', with: password
      click_button 'Login'
    end

    def sign_out
      visit logout_path
    end


    def expect_sign_in_request
      expect(page).to have_current_path(login_path)
    end
  end
end

