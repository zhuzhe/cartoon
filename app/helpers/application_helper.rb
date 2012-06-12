module ApplicationHelper


	def is_active? options
		"active" if params[:controller] == options[:controller] && params[:action] == options[:action]
	end

	def current_user
		User.find(session[:user_id]) if login?
	end

	def login?
		session[:user_id] ? true : false
	end
	
end
