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
  @all = User.where.not(id: current_user.id)
end

# def match
#   user_id = current_user.id.to_i
#   #Create an array of hashes, each hash will have :
#   #exercise_id: id of the exercise
#   #exercise_name : exercise name
#   #users : array of users who share an interest in exercise_id
#   #each item in the users array is a hash with :
#   #user_id,
#   #user_name
#   @result = []
#   @exercise_ids = UserExercise.where(user_id: user_id).map { |a| a.exercise_id }
#   @exercise_ids.each do |exercise_id|
#     #only add to @result if users other than current_user belong to the exercise
#     #it is implied that if there's only one user interested in the exercise, then that user is the current user
#     unless UserExercise.where(exercise_id: exercise_id).length == 1
#       h = {}
#       h[:exercise_id]= exercise_id
#       h[:exercise_name] = Exercise.find(exercise_id).exercise_name
#       users = []
#       UserExercise.where(exercise_id: exercise_id).each do |row|
#         unless row.user_id == user_id
#           userHash = {}
#           userHash[:user_id]= row.user_id
#           userHash[:user_email]= User.find(row.user_id).email
#           userHash[:user_name]= User.find(row.user_id).name
#           users.push(userHash)
#         end
#       end
#       h[:users]= users
#       @result.push(h)
#        end
#      end
#   # puts abc
#   @result = abc
#     #  return @result
#    end

  def match
    #takes an array of exercise ids and
  #returns an array of hashes
  #with keys :
        #u: an instance of User
        #e: an array of Exercises
  #the users each have in common one or more exercises with the current user
  #the returned array is sorted by the number of exercises shared with current user in descending order
  matched_exercises = [3, 1, 5, 7]
  me = matched_exercises
  result = []
  users = []
  #for each of the matched exercises |e|
  matched_exercises.each do |e|
    #for each user |u| who have an interest in e
    exercise_name = Exercise.find(e).exercise_name
    users = UserExercise.where(exercise_id: e).map {|e| e.user_id}
    users.each do |u|
      unless u == current_user.id   #exclude current user
        puts "exercise: #{e} // user id: #{u}"
        #find u in result
        if not result.any? { |ha| ha[:user_id] == u }
          # add u to result
          #if u not include result, add it
          h = {
            :user_id => u,
            :user => User.find(u),
            :matches => []
          }
          result.push h
        else
          #if u already in result, assign hash to h
          h = result.select{ |h| h[:user_id] == u }[0]
        end
        #push e to u
        matches_hash = {
          :exercise_id => e,
          :exercise_name => exercise_name
        }
        h[:matches].push(matches_hash)
      end
    end
  puts "after exercise id (#{e}): result = #{result}"
  end
  #sort result by the number of matched exercises from greatest to least
  result.sort_by! { |x| x[:matches].length}
@result = result.reverse
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
