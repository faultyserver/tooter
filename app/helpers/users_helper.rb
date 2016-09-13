module UsersHelper
  def user_handle user
    "@#{user.handle}"
  end
end
