class DashboardController < ApplicationController
	layout 'layouts/application'
	before_filter :authenticate_user!, :except => [:index]

	def index
	  @user = User.find current_user.id
	end

	def edit
	  @user = User.find current_user.id
	end

	def update
	  @user = User.find current_user.id
	  @status = false
	  	if @user.update_attributes(user_params)
	  	  @status = true
	  	else
	  	  @error_messages = @user.errors.full_messages
	  	end
	  respond_to do |format|
	  	format.js
	  end
	end

	private

	def user_params
	  params.require(:user).permit(:id, :avatar, :first_name, :last_name, :email, :password, :password_confirmation)
	end
end
