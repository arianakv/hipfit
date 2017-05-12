Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV.fetch('FACEBOOK_ID'), ENV.fetch('FACEBOOK_SECRET'), scope: "public_profile, email, user_friends", info_fields: "name, email, friends" 
end
