class UsersController < ApplicationController
	def index
		@users = User.all
	end
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "User created"
			redirect_to root_path
		else
			flash.now[:danger] = "Problem with user."
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private

		def user_params
			params.require(:user).permit(:first_name, :last_name, :email)
		end

end