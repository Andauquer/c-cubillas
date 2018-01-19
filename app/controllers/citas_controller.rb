class CitasController < ApplicationController
  
  def new
    @cita = Cita.new
  end
  
  def create
    @cita = Cita.new(cita_params)
    if @cita.save
      flash[:success] = "La informacion de la cita ha sido registrada."
      redirect_to home_path
    else
      render 'new'
    end
  end
  
  def show
    @cita = Cita.find(params[:id])
  end
  
  private
  
  def cita_params
    params.require(:cita).permit(:symptoms, :medicines, :cares, :annotations)
  end
  
end