class AdminsController < ApplicationController
  
  #Ya que no tenemos acceso directo a la accion "edit", controlamos su ejecucion, al controlar
  #el metodo "verificar_bd"
  before_action :require_user, only: [:verificar_bd, :update]
  before_action :verificar_bd, only: [:new]
  
  def new
    @admin = Admin.new
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
    @admin = Admin.new(admin_params)
    if @admin.save
      flash[:success] = "Su informacion ha sido registrada."
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  private
  
  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation, :password_actual)
  end
  
  def verificar_bd
    if Admin.count == 1
      @admin = Admin.first
      render 'edit'
    end
  end

end
  
