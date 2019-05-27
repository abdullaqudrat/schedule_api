class Schedule
  attr_reader :name, :appointments
  def initialize(name)
    @name = name
    @appointments = []
  end

  def sort_appointments
    @appointments.sort_by! do |appointment|
      appointment.start_time
    end
  end

  def check_overlap(new_appointment)
    @appointments.find do |a|
      new_appointment.start_time <= a.end_time && a.start_time <= new_appointment.end_time
    end
  end
end