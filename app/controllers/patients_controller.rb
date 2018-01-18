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
    @admin = Admin.find(params[:id])
    if params[:admin][:email].empty?                 
      @admin.errors.add(:base, "El campo de correo electronico no puede estar vacio.")
      render 'edit'
    elsif params[:admin][:password] != params[:admin][:password_confirmation]
      @admin.errors.add(:base, "Las contraseñas ingresadas no son iguales.")
      render 'edit'
    elsif params[:admin][:password_actual].empty?
      @admin.errors.add(:base, "Debe ingresar su contraseña actual para poder hacer efectivos los cambios.")
      render 'edit'
    elsif !@admin.authenticate(params[:admin][:password_actual])
      @admin.errors.add(:base, "La contraseña actual ingresada no es correcta.")
      render 'edit'
    else      
      @admin.update(admin_params.except(:password_actual))
      flash[:success] = "Sus credenciales han sido actualizadas."
      redirect_to credenciales_path
    end
  end
  
  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      flash[:success] = "La informacion del paciente ha sido registrada."
      redirect_to home_path
    else
      render 'new'
    end
  end
  
  def listar
    #De esta manera especificamos la paginacion en el muestro de articulos
    @patients = Patient.paginate(page: params[:page], per_page: 3)
  end
  
  private
  
  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :age, :address, :email, :home_number, :phone_numer, :blood_type, :annotations)
  end
  
  def verificar_bd
    if Admin.count == 1
      @admin = Admin.first
      render 'edit'
    end
  end
  
end