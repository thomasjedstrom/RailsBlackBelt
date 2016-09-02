class LendersController < ApplicationController

	def create_user
	  	@lender = Lender.new(lender_params)
		if @lender.save()
			session[:user_id] = @lender.email
			redirect_to lender_show_path(:id => @lender.id)
		else
			flash[:reg_lender_errors] = @lender.errors.full_messages
			redirect_to online_lending_register_path
		end
	end

	def show
		@lender = current_user
		@help = Borrower.all.where(:money > :raised)
		@helped = current_user.borrowers.group(:id)
	end

	def lend
		lender = current_user
		lender.money -= params[:params][:money].to_i

		borrower = Borrower.find(params[:params][:borrower_id])
		borrower.raised += params[:params][:money].to_i

		history = lender.history.new
		history.amount = params[:params][:money]
		history.borrower = borrower
		history.lender = lender

		history.save
		borrower.updating_password = false
		borrower.save
		lender.save

		redirect_to lender_show_path(:id => current_user.id)
	end


	private
	def lender_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :money)
	end
end
