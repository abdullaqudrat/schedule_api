class Schedule
  # has_many :appointments
  
  attr_reader :name
  def initialize(name)
    @name = name
  end

end