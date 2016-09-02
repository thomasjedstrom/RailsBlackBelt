class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	def require_correct_user
		user = User.find(params[:id])
		if current_user != user
			flash[:user_error] = "You are not authorized for that action"
			redirect_to root_path
		end
	end

	def require_login
		redirect_to root_path if session[:user_id] == nil
  	end

	def current_user
		User.find(session[:user_id]) if session[:user_id]
	end

	def user_signed_in?
		!current_user.nil?
	end


	helper_method :current_user


end
