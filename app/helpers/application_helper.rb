module ApplicationHelper

	FORMAT_TIME = "%y/%m/%d"
	FORMAT_TIME_MD = "%m月%d日"

	def is_active? options
		"active" if params[:controller] == options[:controller] && params[:action] == options[:action]
	end

	def current_user
		User.find(session[:user_id]) if login?
	end

	def login?
		session[:user_id] ? true : false
	end

	def timeformat time
		s = time.strftime(FORMAT_TIME)
		if s == Time.now.strftime(FORMAT_TIME)
			return '今天'
		end

		if s == Time.now.yesterday.strftime(FORMAT_TIME)
			return "昨天"
		end
		time.strftime(FORMAT_TIME_MD)
	end
	
end
