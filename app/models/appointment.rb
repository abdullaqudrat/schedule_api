class Appointment
  # belongs_to :schedule
  
  attr_reader :name
  def initialize(name)
    @name = name
  end

end