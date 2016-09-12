module SessionManagement
  # Start a new session as the given user. The user must exist before a call to
  # this method.
  def login_as user
    # Should be equivalent to:
    #   post 'sessions#create', params: { handle: user.handle, password: user.password }
    # But without the need for a known password.
    session[:user_id] = user.id
  end

  # Start a new session as a new user. The user will be a newly-created record,
  # and will be returned for reference in the rest of the spec.
  def login
    create(:user).tap{ |user| login_as(user) }
  end

  # End the current user session. Returns the ID of the user that has been
  # signed out, or nil if no session existed.
  def logout
    user_id = session[:user_id]
    session[:user_id] = nil
    user_id
  end
end
