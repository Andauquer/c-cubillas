class AdminsController < ApplicationController
  
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
  
  def show

  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password)
  end

end
  
