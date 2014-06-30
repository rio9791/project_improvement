class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def connect
  	provider = env["omniauth.auth"]["provider"]
  	case provider
  	  when "linkedin"
    	@user = User.connect_to_linkedin(request.env["omniauth.auth"],current_user)
      when "facebook"
      	@user = User.connect_to_facebook(request.env["omniauth.auth"],current_user)
      when "twitter"
        @user = User.connect_to_twitter(request.env["omniauth.auth"],current_user)
    end

    if @user.persisted?
      case provider
        when "linkedin"
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "LinkedIn"
        when "facebook"
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
        when "twitter"
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      end
      sign_in_and_redirect @user, :event => :authentication
    else
      case provider
        when "linkedin"
          session["devise.linkedin_uid"] = request.env["omniauth.auth"]
        when "facebook"
          session["devise.facebook_data"] = request.env["omniauth.auth"]
      end
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.connect_to_gplus(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
  end

end