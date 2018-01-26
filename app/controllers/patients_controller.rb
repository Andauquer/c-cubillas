class PatientsController < ApplicationController
  
  before_action :require_user

  def new
    @patient = Patient.new
  end
  
  def index
    if params[:nombre].present?
      @q = Patient.ransack(first_name_cont: params[:nombre], last_name_cont: params[:nombre], m: 'or')
      @patients = @q.result.paginate(page: params[:page], per_page: 8)
    elsif params[:commit].present?
      @q = Patient.ransack(first_name_cont: params[:q][:first_name_cont], last_name_cont: params[:q][:first_name_cont], m: 'or')
      @patients = @q.result.paginate(page: params[:page], per_page: 8)
    else
      @q = Patient.ransack(params[:q])
      @patients = @q.result.paginate(page: params[:page], per_page: 8)
    end
  end
  
  def show
    @patient = Patient.find(params[:id])
  end
  
  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
      flash[:success] = "La informacion del paciente ha sido actualizada."
      redirect_to patient_path(@patient)
    else
      render 'edit'
    end
  end
  
  def create
    @patient = Patient.new(patient_params.except(:new_appointment))
    if @patient.save
      flash[:success] = "La informacion del paciente ha sido registrada."
      if patient_params[:new_appointment].present?
        redirect_to new_appointment_path(patient: @patient.id)
      else
        redirect_to patient_path(@patient)
      end
    else
      if patient_params[:new_appointment].present?
        params[:new_appointment] = true
        render 'new'
      else
        render 'new'
      end
    end
  end
  
  def listar
    @patients = Patient.paginate(page: params[:page], per_page: 3)
  end
  
  def historial
    @patient = Patient.find(params[:id])
    @q = Appointment.ransack(patient_id_eq: @patient.id)
    #Tuve que hacer manualmente el sorting de la fecha de la creacion de la cita, pues Ransack al parecer tiene
    #un error o algo desconocido para mi que impedia hacer un sorting correcto cuando solo se llama a un solo
    #paciente.
    if !params[:q].present?
      @q.sorts = ['created_at desc'] 
    elsif params[:q][:s] == 'created_at asc'
      @q.sorts = ['created_at asc'] 
    elsif params[:q][:s] == 'created_at desc'
      @q.sorts = ['created_at desc']
    end
    @patients = @q.result.paginate(page: params[:page], per_page: 8)
  end
  
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    flash[:success] = "El registro del paciente fue eliminado."
    redirect_to patients_path
  end
  
  def edit
    @patient = Patient.find(params[:id])
  end
  
  private
  
  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :age, :address, :email, :home_number, :phone_numer, :blood_type, :annotations, :new_appointment)
  end
  
  def verificar_bd
    if Admin.count == 1
      @admin = Admin.first
      render 'edit'
    end
  end
  
end