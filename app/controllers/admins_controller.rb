class AdminsController < ApplicationController
  
  before_action :verificar_bd, only: [:new]
  
  def new
    @admin = Admin.new
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
  
  def admin_params
    params.require(:admin).permit(:email, :password)
  end
  
  def verificar_bd
    if Admin.count == 1 
      render 'edit'
    end
  end

end
  
