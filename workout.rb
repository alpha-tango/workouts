class Workout
attr_accessor :id, :type, :duration, :calories
  def initialize(workout_hash)
    @date = workout_hash[:date]
    @exercises = workout_hash[:exercises]
    @id = 0
    @type = get_type
    @duration = get_duration
    @calories = get_calories
  end

  def exercises
    @exercises
  end

  def date
    @date
  end

  def get_type
    types = {strength: 0, cardio: 0, other: 0}

    exercises.each do |exercise|
      if exercise[:category] == "cardio"
        types[:cardio]+=1
      elsif exercise[:category] =="strength"
        types[:strength]+=1
      else
        types[:other]+=1
      end
    end

    types.each do |key, value|
      if value > exercises.length/2
        return @type = key.to_s
      else
        @type = "other"
      end
    end
    @type
  end

  def get_duration
    duration = 0
    exercises.each do |exercise|
      duration+=exercise[:duration_in_min]
    end
    duration.to_f
  end

  def get_calories
    calories = 0
    cal_intensity = {high: 10, medium: 8, low: 5, other: 6}
    exercises.each do |exercise|
      if exercise[:intensity] == nil && exercise[:category] == "strength"
        calories += exercise[:duration_in_min] * cal_intensity[:low]
      elsif exercise[:intensity] == nil
        calories += exercise[:duration_in_min] * cal_intensity[:other]
      else
        calories += exercise[:duration_in_min] * cal_intensity[exercise[:intensity].to_sym]
      end
    end
    calories.to_f
  end
end
