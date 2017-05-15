class UsersController < ApplicationController

  def new
    User.new
  end

  def info
  end

  def exercises
    @user = current_user
    @exercises = Exercise.all
  end

  def assign
    #method to store user's exercise preference into join table
    #called by the 'Submit' on the exercises form
    #using value of "1" to detect which checkboxes are selected
    redirect_to "/user_profile"
    params.each do |key, value|
      puts "key= #{key} // value = #{value}"
      if value == "1"
        puts addExercise(current_user.id, key)
      end
  end
end

  def show
 @all = User.all
  end

  def match
  end

  def get_exercise_name_from_id(id)
    name= Exercise.find(id)[:exercise_name]
  end

  def addExercise(user_id, exercise_id)
    u = UserExercise.new
    u.user_id = user_id
    u.exercise_id = exercise_id
    u.save
    return u
  end

  def edit
    @user = User.find(params[:id])
end

end
