class Users::RegistrationsController < Devise::RegistrationsController
  layout 'application'

  def new
    super
  end

  def create
    build_resource(sign_up_params)
    @status = false
    if resource.save
      @status = true
    else
      @error_messages = resource.errors.full_messages
    end
    respond_to do |format|
      format.js
    end
  end

   private

   def sign_up_params
     params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
   end

   protected

   def after_inactive_sign_up_path_for(resource)
     home_index_path
   end
end