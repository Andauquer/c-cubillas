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
    if params[:admin][:password].empty?                  # Case (3)
      @admin.errors.add(:password, "No puede estar vacio")
      render 'edit'
    elsif @admin.update_attributes(admin_params)          # Case (4)
      flash[:success] = "La contraseña se ha reseteado."
      redirect_to root_path
    else
      render 'edit'                                     # Case (2)
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
