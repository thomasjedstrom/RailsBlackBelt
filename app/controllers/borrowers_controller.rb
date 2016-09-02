class BorrowersController < ApplicationController
	
	def create_user
	  	borrower = Borrower.new(borrower_params)
		if borrower.save()
			session[:user_id] = borrower.email
			redirect_to borrower_show_path(:id => borrower.id)
		else
			flash[:reg_borrower_errors] = borrower.errors.full_messages
			redirect_to online_lending_register_path
		end
	end

	def show
		@borrower = current_user
		puts '----------'
		puts current_user
		puts @borrower
		puts '----------'
		@help = Borrower.all
		@helped = Borrower.all
	end


	private
	def borrower_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :money, :purpose, :description)
	end

end
