class HomeController < ApplicationController

	def index
		if user_signed_in?
			return nil
		else
			redirect_to online_lending_login_path
		end
	end

	def login
	end

	def register
	end

	def login_user
		lender = Lender.find_by_email(params[:email])
		borrower = Borrower.find_by_email(params[:email])
		if lender && lender.authenticate(params[:password])
			session[:user_id] = lender.email
			redirect_to lender_show_path(:id => lender.id)
		elsif borrower && borrower.authenticate(params[:password])
			session[:user_id] = borrower.email
			redirect_to borrower_show_path(:id => borrower.id)
		else
			flash[:login_error] = ["Invalid combination"]
			redirect_to online_lending_login_path
		end
	end

	def logout
		session[:user_id] = nil
		redirect_to online_lending_login_path
	end

	private
	def login_params
		params.require(:user).permit(:email, :password)
	end
end
