class Api::V1::AppointmentController < ApplicationController
  before_action :clean_params, only: [:create, :show, :destroy]

  def show
    schedule = Rails.cache.read(@schedule_name)
    appointment = schedule.appointments.find { |appointment| appointment.name == @appointment_name }
    if schedule && appointment
      render json: appointment
    else
      render json: {message: "error", status: 404}
    end
  end
  
  def create
    schedule = Rails.cache.read(@schedule_name) unless params[:schedule_id].nil?
    new_appointment = Appointment.new(@param_name, params[:start_time], params[:end_time]) unless params[:name].nil?
    if schedule && new_appointment && new_appointment.check_time == true && schedule.check_overlap(new_appointment).nil?
      schedule.appointments << new_appointment
      Rails.cache.write(schedule.name, schedule)
      render json: {message: "Added #{new_appointment.name} to #{schedule.name}"}
    else
      render json: {message: "error", status: 404}
    end
  end

  def destroy
    schedule = Rails.cache.read(@schedule_name)
    appointment = schedule.appointments.find { |appointment| appointment.name == @appointment_name }
    if schedule.appointments.delete(appointment)
      Rails.cache.write(schedule.name, schedule)
      render json: {message: "Deleted appointment"}
    else
      render json: {message: "error", status: 404}
    end
  end

  private
  def clean_params
    if params[:schedule_id]
      @schedule_name = params[:schedule_id].gsub(/[-_]/, '-' => ' ', '_' => ' ')
    end
    if params[:id]
      @appointment_name = params[:id].gsub(/[-_]/, '-' => ' ', '_' => ' ')
    end
    if params[:name]
      @param_name = params[:name].gsub(/[-_]/, '-' => ' ', '_' => ' ')
    end
  end
end