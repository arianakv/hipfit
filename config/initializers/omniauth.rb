Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV.fetch('FACEBOOK_ID'), ENV.fetch('FACEBOOK_SECRET'), :image_size => 'large', scope: "public_profile, email, user_friends, user_location", info_fields: "name, email, picture, age_range, location, gender, friends, link" 
end
