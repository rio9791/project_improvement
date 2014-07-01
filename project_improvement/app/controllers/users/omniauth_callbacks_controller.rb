class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def connect
  	provider = env["omniauth.auth"]["provider"]
  	case provider
  	  when "linkedin"
    	  @user = User.connect_to_linkedin(request.env["omniauth.auth"],current_user)
      when "facebook"
      	@user = User.connect_to_facebook(request.env["omniauth.auth"],current_user)
      when "twitter"
        @user = User.find_for_twitter_oauth(request.env["omniauth.auth"].provider, request.env["omniauth.auth"].uid, request.env["omniauth.auth"].extra.raw_info.name, request.env["omniauth.auth"].info.email, current_user)
      when "gplus"
        @user = User.connect_to_gplus(request.env["omniauth.auth"], current_user)
    end

    if @user.persisted?
      case provider
        when "linkedin"
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "LinkedIn"
        when "facebook"
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
        when "twitter"
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
        when "gplus"
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      end
      sign_in_and_redirect @user, :event => :authentication
    else
      case provider
        when "linkedin"
          session["devise.linkedin_uid"] = request.env["omniauth.auth"]
        when "facebook"
          session["devise.facebook_data"] = request.env["omniauth.auth"]
        when "twitter"
          session["devise.twitter_data"] = request.env["omniauth.auth"].select { |k, v| k == "email" }
        when "google"
          session["devise.facebook_data"] = request.env["omniauth.auth"]
      end
      redirect_to new_user_registration_url
    end
  end

end