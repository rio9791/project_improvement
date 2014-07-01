Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "758y6dyuvfm4q5", "rLI27TFwrFDoae7f", :scope => "r_basicprofile r_emailaddress r_fullprofile"
  provider :facebook, "260481134155934", "b02d94183239e31344a3ef674819cc52"
  provider :twitter, "QNgACRQIvgmkgYOlQMWDCxOMu", "32wRbDQdBLybGfTwJLS6ckw6GzxQ2kZW5SMywfYTtEMgBmegB2"
  provider :gplus, "1001229313863-sk06ugj3rjio9351s2t1oitc6ds2sv0o.apps.googleusercontent.com", "7uiNm-5EIfWYojZ3qs6-G0Gf"
end