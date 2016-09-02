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

	end
end
