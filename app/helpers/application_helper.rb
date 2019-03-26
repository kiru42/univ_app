module ApplicationHelper
  def session_link
    if(logged_in?)
      link_to("logout", logout_path, method: :delete)
    else
      link_to("log in", login_path)
    end
  end
end
