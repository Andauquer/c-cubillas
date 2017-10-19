class PasswordResetsController < ApplicationController

  before_action :get_admin, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @admin = Admin.first
    if @admin
      @admin.create_reset_digest
      @admin.send_password_reset_email
      flash[:success] = "Las instrucciones para cambiar su contraseña han sido enviadas a su correo."
      redirect_to root_path
    else
      flash[:danger] = "Sus credenciales aun no han sido establecidas"
      redirect_to root_path
    end
  end

  def edit
  end
  
  def update
    if params[:admin][:password].empty?                 
      @admin.errors.add(:base, "No se ingreso ninguna contraseña")
      render 'edit'
    elsif params[:admin][:password] != params[:admin][:password_confirmation]
      @admin.errors.add(:base, "Las contraseñas ingresadas no son iguales.")
      render 'edit'  
    else      
      @admin.update_attributes(admin_params)
      flash[:success] = "La contraseña se ha reseteado."
      redirect_to root_path
    end
  end
  
  private
  
  def admin_params
    params.require(:admin).permit(:password, :password_confirmation)
  end
  
  def get_admin      
    @admin = Admin.find_by(email: params[:email])
  end
  
  # Checks expiration of reset token.
  def check_expiration
    if @admin.password_reset_expired?
      flash[:danger] = "El enlace para resetear la contraseña ha expirado."
      redirect_to new_password_reset_url
    end
  end

end
