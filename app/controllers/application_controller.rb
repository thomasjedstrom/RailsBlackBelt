class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	after_filter :set_header_for_iframe

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
		return unless session[:user_id]
		if lenderid = Lender.find_by_email(session[:user_id])
			Lender.find(lenderid)
		else 
			borrowerid = Borrower.find_by_email(session[:user_id])
			Borrower.find(borrowerid)
		end
	end

	def user_signed_in?
		!current_user.nil?
	end


	helper_method :current_user


	private
	def set_header_for_iframe
		response.headers.delete "X-Frame-Options" 
	end

end
