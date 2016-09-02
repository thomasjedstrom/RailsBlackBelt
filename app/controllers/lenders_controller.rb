class LendersController < ApplicationController

	def create_user
	  	@lender = Lender.new(lender_params)
		if @lender.save()
			session[:user_id] = @lender.id
			redirect_to lender_show_path(:id => @lender.id)
		else
			flash[:reg_lender_errors] = @lender.errors.full_messages
			redirect_to online_lending_register_path
		end
	end

	def show
		@lender = current_user
	end


	private
	def lender_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :money)
	end
end
