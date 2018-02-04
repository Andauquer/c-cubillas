class AnamnesisController < ApplicationController
  
  before_action :require_user
  
  def new
    @anamnesi = Anamnesi.new
  end
  
  def create
    @anamnesi = Anamnesi.new(anamnesi_params)
    if @anamnesi.save
      flash[:success] = "La informacion de la consulta ha sido registrada."
      redirect_to anamnesi_path(@anamnesi)
    else
      params[:patient] = @anamnesi.patient_id
      render 'new'
    end
  end
  
  def show
    @anamnesi = Anamnesi.find(params[:id])
  end
  
  def index
    if params[:commit].present?
      @q = Anamnesi.ransack(patient_first_name_cont: params[:q][:patient_first_name_cont], patient_last_name_cont: params[:q][:patient_first_name_cont], m: 'or')
      @q.sorts = ['created_at desc'] if @q.sorts.empty?
      @anamnesis = @q.result.paginate(page: params[:page], per_page: 8)
    else
      @q = Anamnesi.ransack(params[:q])
      @q.sorts = ['created_at desc'] if @q.sorts.empty?
      @anamnesis = @q.result.paginate(page: params[:page], per_page: 8)
    end
  end
  
  def destroy
    @anamnesi = Anamnesi.find(params[:id])
    @anamnesi.destroy
    flash[:success] = "El registro de la consulta fue eliminado."
    redirect_to anamnesis_path
  end
  
  def edit
    @anamnesi = Anamnesi.find(params[:id])
  end
  
  def update
    @anamnesi = Anamnesi.find(params[:id])
    if @anamnesi.update(anamnesi_params)
      flash[:success] = "La informacion de la consulta ha sido actualizada."
      redirect_to anamnesi_path(@anamnesi)
    else
      params[:patient] = @anamnesi.patient_id
      render 'edit'
    end
  end
  
  private
  
  def anamnesi_params
    params.require(:anamnesi).permit(:sp, :hea, :fog, :ape, :apa, :afa, :sv, :pa, :fr, :p, :t, :fcyp, :tc, :orl, :cp, :abd, :ext, :pyf, :idx, :tx, :annotations, :patient_id)
  end
  
end