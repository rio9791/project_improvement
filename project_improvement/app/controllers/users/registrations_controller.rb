class Users::RegistrationsController < Devise::RegistrationsController
	layout 'application'

	def new
	  super
	end

	def create
	  if verify_recaptcha
      	super
   	  else
   	  	build_resource(sign_up_params)
      	clean_up_passwords(resource)
      	resource.valid?
      	flash[:alert] = "There was an error with the recaptcha code below. Please re-enter the code.\n"
      	flash.delete :recaptcha_error
      	render :new
   	  end
	end

   private

   def sign_up_params
     params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
   end

   protected

   def after_inactive_sign_up_path_for(resource)
     dashboard_index_path
   end
end