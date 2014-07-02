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
	  respond_to do |format|
	  	if @user.update_attributes(user_params)
	  	  format.js { render json: true }
	  	else
	  	  format.js { render json: false }
	  	end
	  end
	end

	private

	def user_params
	  params.permit(:id, :avatar, :first_name, :last_name, :email, :password, :password_confirmation, :skip_validation => true)
	end
end
