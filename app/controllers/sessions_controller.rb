class SessionsController < ApplicationController
  def create
      # omniauth middleware stores oauth data in the request.env instead of params

      auth = request.env["omniauth.auth"]
      require 'pp'
      pp auth
      # access_token = auth.credentials.token

      # even though this is a login action, an OAuth login can be a login *or* a registration
      #
      # if the user exists, log her in
      # if the user doesn't exist, create her, then log her in
      user = User.find_by(facebook_id: auth['uid']) || User.create_from_facebook(auth)
      user.picture = auth['info']['image']
      user.age_range = auth['extra']['raw_info']['age_range']['min']
      user.user_location = auth['info']['location']
      user.gender = auth['extra']['raw_info']['gender']
      user.link = auth['info']['urls']['Facebook']
      user.save
      session[:user_id] = user.id
      redirect_to user_profile_url, notice: "Signed in!"
    end

    # logout
    def destroy
      reset_session
      redirect_to root_url, notice: "Signed out!"
    end
  end
