require_relative 'workout'
require 'csv'
require 'pry'
require 'table_print'

# create a hash of workout info from CSV
def load_workout_data(filename)
  workouts = {}

  CSV.foreach(filename, headers: true, header_converters: :symbol, converters: :numeric) do |row|
    workout_id = row[:workout_id]

    if !workouts[workout_id]
      workouts[workout_id] = {
        date: row[:date],
        exercises: []
      }
    end

    exercise = {
      name: row[:exercise],
      category: row[:category],
      duration_in_min: row[:duration_in_min],
      intensity: row[:intensity]
    }

    workouts[workout_id][:exercises] << exercise
  end

  workouts
end

workouts = load_workout_data('workouts.csv')

workout_array = []

workouts.each do |id, workout|
 each_workout = Workout.new(workout)
 each_workout.id = id
 workout_array << each_workout
end

tp workout_array, ["id", "date", "type", "duration", "calories"]
