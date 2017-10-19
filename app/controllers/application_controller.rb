class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #Con este siguiente linea de comando, podemos usar estos metodos en nuestros views, de lo contrario, 
  #solo se podrian usar en los otros archivos controllers.
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= Admin.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #Con esta linea, si current_user existe, retornara true, de lo contrario, retornara false.
    !!current_user
  end

  def require_user
    if !logged_in?
      redirect_to root_path
    end
  end

end
