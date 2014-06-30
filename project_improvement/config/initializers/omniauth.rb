Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "758y6dyuvfm4q5", "rLI27TFwrFDoae7f", :scope => "r_basicprofile r_emailaddress r_fullprofile"
  provider :facebook, "260481134155934", "b02d94183239e31344a3ef674819cc52"
  provider :twitter, "QNgACRQIvgmkgYOlQMWDCxOMu", "32wRbDQdBLybGfTwJLS6ckw6GzxQ2kZW5SMywfYTtEMgBmegB2"
  provider :google_oauth2, "1001229313863-8d4i8onge1jgdkr2v668l5i6ja6r1q4o.apps.googleusercontent.com", "68fumgVgxBV5y3r1GfADvqrP"
end