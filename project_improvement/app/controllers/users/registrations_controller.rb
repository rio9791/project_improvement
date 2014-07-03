class Users::RegistrationsController < Devise::RegistrationsController
	layout 'application'

	def new
	  super
	end

	def create
    respond_to do |format|
      if verify_recaptcha
        build_resource(sign_up_params)
        resource_saved = resource.save
        yield resource if block_given?
        if resource_saved
          if resource.active_for_authentication?
            set_flash_message :notice, :signed_up if is_flashing_format?
            sign_up(resource_name, resource)
          else
            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
            expire_data_after_sign_in!
            respond_with resource, location: after_inactive_sign_up_path_for(resource)
            format.js { render json: true }
          end
        else
          clean_up_passwords resource
          respond_with resource
          format.js { render json: false }
        end
      else
        build_resource(sign_up_params)
        clean_up_passwords(resource)
        resource.valid?
        format.js { render json: false }
      end
    end
	end

   private

   def sign_up_params
     params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
   end

   protected

   def after_inactive_sign_up_path_for(resource)
     dashboard_index_path
   end
end