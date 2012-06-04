module ApplicationHelper


	def is_active? options
		"active" if params[:controller] == options[:controller] && params[:action] == options[:action]
	end
end
