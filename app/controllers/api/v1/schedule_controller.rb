class Api::V1::ScheduleController < ApplicationController
  def create
    new_schedule = Schedule.new(schedule_params)
    if new_schedule.save
      render json: new_schedule
    else
      render json: {message: "error"}
    end
  end

  private
    def schedule_params
      params.require(:schedule).permit(:name)
    end
end

