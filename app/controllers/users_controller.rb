class UsersController < ApplicationController

  def new
  end

  def info
  end

  def exercises
    @user = User.find(1)
    @exercises = Exercise.all
  end

  def assign
    redirect_to "/user_profile"
    puts "YAY"
  end

end
