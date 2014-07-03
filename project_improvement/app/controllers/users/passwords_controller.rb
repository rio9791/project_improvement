class Users::PasswordsController < Devise::PasswordsController
	layout 'application'

	def new
	  super
	end

	def create
	  self.resource = resource_class.send_reset_password_instructions(resource_params)
      @status = false
      if successfully_sent?(resource)
        @status = true
      else
        @error_messages = resource.errors.full_messages
      end
      respond_to do |format|
      	format.js
      end
	end



end