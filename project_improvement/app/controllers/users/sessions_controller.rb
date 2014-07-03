class Users::SessionsController < Devise::SessionsController

  def new
  	super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    # set_flash_message(:notice, :signed_in) if is_flashing_format?
    # yield resource if block_given?
    # respond_with resource, location: after_sign_in_path_for(resource)
    @status = false
    if sign_in(resource_name, resource)
      @status = true
    else
      @error_messages = resource.errors.full_messages
    end
    respond_to do |format|
      format.js
    end
  end

  protected

  def after_sign_in_path_for(resource)
    dashboard_index_path
  end

end