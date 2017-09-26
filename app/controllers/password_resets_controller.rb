class PasswordResetsController < ApplicationController

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

end
