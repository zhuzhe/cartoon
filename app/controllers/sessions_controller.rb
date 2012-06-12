class SessionsController < ApplicationController

	def new
		if login?
			redirect_to root_path
		end
	end

	def create
		user = User.authenticate(params[:email], params[:password])
		if user
			session[:user_id] = user.id
			redirect_to :back
		else
			flash[:error] = "邮箱或者密码错误"
			render :action => :new
		end
	end

	def destroy
		logout
		redirect_to root_path
	end

end
