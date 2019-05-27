class Api::V1::ScheduleController < ApplicationController
  before_action :set_schedule, only: [:index]
  
  def index 
    render json: @schedule
  end

  def create
    new_schedule = Schedule.new(params[:name]) unless params[:name].nil?
    if new_schedule && Rails.cache.write("schedule", new_schedule)
      render json: {message: "Schedule '#{Rails.cache.read("schedule").name}' created"}
    else
      render json: {message: "error"}
    end
  end

  def destroy
    if Rails.cache.delete("schedule")
      render json: {message: "Deleted schedule"}
    else
      render json: {message: "error", status: 404}
    end
  end

  private
    def set_schedule
      @schedule = Rails.cache.read("schedule")
    end
end

