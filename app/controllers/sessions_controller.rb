class SessionsController < ApplicationController

  def new
  
  end
  
  def create
    admin = Admin.first
    
    if admin && admin.authenticate(params[:session][:password])
      session[:user_id] = admin.id
      flash[:success] = "Bienvenido, Dr. Cubillas"
      redirect_to credenciales_path
    else
      flash.now[:danger] = "Hubo un problema con el inicio de sesion, intente ingresar nuevamente la contraseña."
      render 'new'
    end
    
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "Se ha desconectado del sistema exitosamente."
    redirect_to root_path
  end

end