class Api::V1::AppointmentController < ApplicationController
  def show
    schedule = Rails.cache.read(params[:schedule_id])
    appointment = schedule.appointments.find { |appointment| appointment.name == params[:id] }
    if schedule && appointment
      render json: appointment
    else
      render json: {message: "error", status: 404}
    end
  end
  
  def create
    schedule = Rails.cache.read(params[:schedule_id]) unless params[:schedule_id].nil?
    new_appointment = Appointment.new(params[:name], params[:start_time], params[:end_time]) unless params[:name].nil?
    if schedule && new_appointment && new_appointment.check_time == true
      schedule.appointments << new_appointment
      Rails.cache.write(schedule.name, schedule)
      render json: {message: "Added #{new_appointment.name} to #{schedule.name}"}
    else
      render json: {message: "error", status: 404}
    end
  end
end