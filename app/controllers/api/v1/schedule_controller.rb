class Api::V1::ScheduleController < ApplicationController
  
  def show 
    schedule = Rails.cache.read(params[:id])
    if schedule
      render json: schedule
    else
      render json: {message: "error", status: 404}
    end
  end

  def create
    new_schedule = Schedule.new(params[:name]) unless params[:name].nil?
    if new_schedule && Rails.cache.write(new_schedule.name, new_schedule)
      render json: {message: "Schedule '#{Rails.cache.read(new_schedule.name).name}' created"}
    else
      render json: {message: "error"}
    end
  end

  def destroy
    if Rails.cache.delete(params[:id])
      render json: {message: "Deleted schedule"}
    else
      render json: {message: "error", status: 404}
    end
  end

  private
    def set_schedule
      
    end
end

