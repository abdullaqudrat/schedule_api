class Api::V1::ScheduleController < ApplicationController
  before_action :clean_schedule_params, only: [:create, :show, :destroy]
  
  def show 
    schedule = Rails.cache.read(@schedule_name)
    if schedule && schedule.sort_appointments
      Rails.cache.write(schedule.name, schedule)
      render json: schedule
    else
      render json: {message: "error", status: 404}
    end
  end

  def create
    new_schedule = Schedule.new(@param_name) unless params[:name].nil?
    if new_schedule && Rails.cache.write(new_schedule.name, new_schedule)
      render json: {message: "Schedule '#{Rails.cache.read(new_schedule.name).name}' created"}
    else
      render json: {message: "error"}
    end
  end

  def destroy
    if Rails.cache.delete(@schedule_name)
      render json: {message: "Deleted schedule"}
    else
      render json: {message: "error", status: 404}
    end
  end

  private
    def clean_schedule_params
      if params[:id]
        @schedule_name = params[:id].gsub(/[-_]/, '-' => ' ', '_' => ' ')
      end
      if params[:name]
        @param_name = params[:name].gsub(/[-_]/, '-' => ' ', '_' => ' ')
      end
    end
end

