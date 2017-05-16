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
    user_id = current_user.id.to_i
    #Create an array of hashes, each hash will have :
    #exercise_id: id of the exercise
    #exercise_name : exercise name
    #users : array of users who share an interest in exercise_id
      #each item in the users array is a hash with :
        #user_id,
        #user_name
    @result = []
    @exercise_ids = UserExercise.where(user_id: user_id).map { |a| a.exercise_id }
    @exercise_ids.each do |exercise_id|
      #only add to @result if users other than current_user belong to the exercise
      #it is implied that if there's only one user interested in the exercise, then that user is the current user
      unless UserExercise.where(exercise_id: exercise_id).length == 1
        h = {}
        h[:exercise_id]= exercise_id
        h[:exercise_name] = Exercise.find(exercise_id).exercise_name
        users = []
        UserExercise.where(exercise_id: exercise_id).each do |row|
          unless row.user_id == user_id
            userHash = {}
            userHash[:user_id]= row.user_id
            userHash[:user_email]= User.find(row.user_id).email
            userHash[:user_name]= User.find(row.user_id).name
            users.push(userHash)
          end
        end
      h[:users]= users
      @result.push(h)
      end
    end
    return @result
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
