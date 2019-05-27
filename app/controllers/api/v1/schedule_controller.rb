class Api::V1::ScheduleController < ApplicationController
  def create
    new_schedule = Schedule.new(params[:name]) unless params[:name].nil?
    if new_schedule
      render json: {message: "Schedule '#{new_schedule.name}' created"}
    else
      render json: {message: "error"}
    end
  end
end

