class SessionsController < ApplicationController
  def create
      # omniauth middleware stores oauth data in the request.env instead of params
      auth = request.env["omniauth.auth"]

      # even though this is a login action, an OAuth login can be a login *or* a registration
      #
      # if the user exists, log her in
      # if the user doesn't exist, create her, then log her in
      user = User.find_by(facebook_id: auth['uid']) || User.create_from_facebook(auth)

      session[:user_id] = user.id
      redirect_to root_url, notice: "Signed in!"
    end

    # logout
    def destroy
      reset_session
      redirect_to root_url, notice: "Signed out!"
    end
  end
