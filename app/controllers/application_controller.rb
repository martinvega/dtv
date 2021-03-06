class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Cualquier excepción no contemplada es capturada por esta función. Se utiliza
  # para mostrar un mensaje de error personalizado
  rescue_from Exception do |exception|
    begin
      @title = t('errors.title')
      error = "#{exception.class}: #{exception.message}\n\n"
      exception.backtrace.each { |l| error << "#{l}\n" }

      unless response.redirect_url
        render :template => 'errors/show', :locals => {:error => exception}
      end
      
      logger.error(error)

    # En caso que la presentación misma de la excepción no salga como se espera
    rescue => ex
      error = "#{ex.class}: #{ex.message}\n\n"
      ex.backtrace.each { |l| error << "#{l}\n" }

      logger.error(error)
    end
  end

  private

  # Verifica que el login se haya realizado y el usuario esté activo
  def login_check
    load_auth_user

    !@auth_user.nil?
  end

  # Inicializa la variable @auth_user si hay un usuario autenticado en la sesión
  def load_auth_user
    @auth_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Controla que el usuario esté autenticado
  def auth
    action = (params[:action] || 'none').to_sym

    unless login_check
      go_to = {
        :action => (params[:action] == 'create' ? :new :
          params[:action] == 'update' ? :edit : params[:action]),
        :controller => params[:controller],
        :id => params[:id]
      }
      session[:go_to] = go_to unless action == :logout
      @auth_user = nil
      flash[:alert] = 'Debe estar autenticado'
      redirect_to_login 
    else
      response.headers['Cache-Control'] = 'no-cache, no-store'
    end
  end

  def admin_cat2
    if @auth_user.admin? || @auth_user.category2?
      true
    else
      flash[:alert] = 'Debe ser administrador o categoría 2'
      redirect_to_login 
    end
  end
  
  def admin
    if @auth_user.admin?
      true
    else
      flash[:alert] = 'Debe ser administrador'
      redirect_to_login 
    end
  end
  
  def category2
    unless @auth_user.category2?
      true
    else
      flash[:alert] = 'No tiene permisos para acceder'
      redirect_to_login 
    end
  end
  
  # Redirige la navegación a la página de autenticación, enviando el mensaje
  # indicado
  def redirect_to_login(mensaje = nil)
    flash[:notice] = mensaje if mensaje
    redirect_to login_users_url
  end

  def restart_session
    flash_temp = flash
    reset_session
    flash.replace flash_temp
  end
end
