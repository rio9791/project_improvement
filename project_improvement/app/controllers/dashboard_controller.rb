class DashboardController < ApplicationController

	def index
	  @user = current_user
	end

	def edit
	  @user = User.find params[:id]
	end

	def update
	  @user = User.find params[:user]["id"]
	  respond_to do |format|
	  	if @user.update_attributes(user_params)
	  	  format.html { redirect_to dashboard_index_path, notice: "User profile successfully updated"}
	  	else
	  	  format.html { render :edit, notice: "Error"}
	  	end
	  end
	end

	private

	def user_params
	  params.require(:user).permit(:avatar, :first_name, :last_name, :email, :password, :password_confirmation)
	end
end
