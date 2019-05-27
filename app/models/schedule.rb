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
end