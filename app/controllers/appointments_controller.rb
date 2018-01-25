class AppointmentsController < ApplicationController
  
  before_action :require_user
  
  def new
    @appointment = Appointment.new
  end
  
  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      flash[:success] = "La informacion de la cita ha sido registrada."
      redirect_to appointment_path(@appointment)
    else
      render 'new'
    end
  end
  
  def show
    @appointment = Appointment.find(params[:id])
  end
  
  def index
    if params[:commit].present?
      @q = Appointment.ransack(first_name_cont: params[:q][:patient_first_name_cont], last_name_cont: params[:q][:patient_first_name_cont], m: 'or')
      @q.sorts = ['created_at desc'] if @q.sorts.empty?
      @appointments = @q.result.paginate(page: params[:page], per_page: 8)
    else
      @q = Appointment.ransack(params[:q])
      @q.sorts = ['created_at desc'] if @q.sorts.empty?
      @appointments = @q.result.paginate(page: params[:page], per_page: 8)
    end
  end
  
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    flash[:success] = "El registro de la cita fue eliminado."
    redirect_to appointments_path
  end
  
  def edit
    @appointment = Appointment.find(params[:id])
  end
  
  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      flash[:success] = "La informacion de la cita ha sido actualizada."
      redirect_to appointment_path(@appointment)
    else
      render 'edit'
    end
  end
  
  private
  
  def appointment_params
    params.require(:appointment).permit(:symptoms, :medicines, :cares, :annotations, :patient_id)
  end
  
end