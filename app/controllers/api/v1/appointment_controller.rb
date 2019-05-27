class Api::V1::AppointmentController < ApplicationController
  def create
    schedule = Rails.cache.read(params[:schedule_id]) unless params[:schedule_id].nil?
    new_appointment = Appointment.new(params[:name]) unless params[:name].nil?
    if schedule && new_appointment && schedule.appointments << new_appointment && Rails.cache.write(schedule.name, schedule)
      render json: {message: "Added #{new_appointment.name} to #{schedule.name}"}
    else
      render json: {message: "error"}
    end
  end
end