class AppointmentsController < ApplicationController
  
  def new
    @appointment = Appointment.new
  end
  
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      flash[:success] = "La informacion de la cita ha sido registrada."
      redirect_to home_path
    else
      render 'new'
    end
  end
  
  def show
    @appointment = Appointment.find(params[:id])
  end
  
  def index
    @q = Patient.ransack(params[:q])
    @q.sorts = 'created_at desc' if @q.sorts.empty?
    @patients = @q.result.joins("INNER JOIN appointments ON patients.id = appointments.patient_id").select("patients.*, appointments.*")
  end
  
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    flash[:success] = "El registro de la cita fue eliminado."
    redirect_to appointments_path
  end
  
  private
  
  def appointment_params
    params.require(:appointment).permit(:symptoms, :medicines, :cares, :annotations, :patient_id)
  end
  
end