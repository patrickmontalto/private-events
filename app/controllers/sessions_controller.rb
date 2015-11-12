class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user
			log_in user
			flash[:success] = "Successfully signed in."
			redirect_to root_path
		else
			flash.now[:danger] = "Invalid email"
			render 'new'
		end
	end

	def destroy
		log_out current_user
		redirect_to root_path
	end
end
