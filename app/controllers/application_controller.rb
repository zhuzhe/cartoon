class ApplicationController < ActionController::Base
  protect_from_forgery


  def current_user
  	User.find(session[:user_id]) if login?
  end

  def login?
  	session[:user_id] ? true : false
  end

  def login user
  	session[:user_id] = user.id
  end

  def logout
  	session[:user_id] = nil
  end

  def require_login
  	unless login?
  		redirect_to login_path
  	end
  end

end
