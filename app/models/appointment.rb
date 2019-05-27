class Appointment
  attr_reader :name, :start_time, :end_time
  def initialize(name, start_time, end_time)
    @name = name
    @start_time = start_time
    @end_time = end_time
  end

  def check_time
    if @start_time && @end_time
      @start_time < @end_time
    end
  end
end