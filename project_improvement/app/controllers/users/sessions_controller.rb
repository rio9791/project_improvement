class Users::SessionsController < Devise::SessionsController

  def new
  	super
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # def failure
  #   user = User.find_by_email(session['user_auth'][:email])
  #    message = I18n.t 'devise.failure.invalid'
  #     if user =! nil || user.active_for_authentication?
  #       flash[:error]= message unless request.xhr?
  #    else
  #      flash[:error]= user.inactive_message unless request.xhr?
  #      message = user.inactive_message
  #     end
  #   respond_to do |format|
  #     format.json {render :json => {:authentication => 'failure', :data => {:message => message, :cause => 'invalid'} } }
  #     format.html {redirect_to '/users/sign_in'}
  #   end
  # end

end