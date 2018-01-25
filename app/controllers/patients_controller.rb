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
    #De esta manera especificamos la paginacion en el muestro de articulos
    @patients = Patient.paginate(page: params[:page], per_page: 3)
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