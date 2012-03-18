class UsersController < ApplicationController
  before_filter :auth, :except => [:login, :create_session]
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
  
  # * GET /users/login
  def login
    @title = "Login"
    @user = User.new
  end

  # * POST /users/create_session
  def create_session
    @title = "Login"
    @user = User.new(params[:user])

    auth_user = User.find_by_user(@user.user)
    @user.salt = auth_user.salt if auth_user

    @user.encrypt_password

    if auth_user && auth_user.password && auth_user.password == @user.password then
      session[:last_access] = Time.now
      session[:user_id] = auth_user.id
      if auth_user.admin?
        go_to = session[:go_to] || { :action => :index }
      else
        go_to = {:controller => :contacts, :action => :index}
      end
      session[:go_to] = nil
      redirect_to go_to
    else
      redirect_to_login "El usuario y/o password son incorrectos"
    end
  end
  
  # * GET /users/edit_password/1
  # * GET /users/edit_password/1.xml
  def edit_password
    @title = "Modificar contraseña"
    @auth_user.password = nil
  end

  # * PUT /users/update_password/1
  # * PUT /users/update_password/1.xml
  def update_password
    @user = User.new
    @user.user = @auth_user.user
           
    auth_user = User.find_by_user(@auth_user.user)
    @user.salt = auth_user.salt if auth_user

    @user.encrypt_password
   
    unless auth_user && auth_user.password 
      flash[:alert] = "Debe iniciar sesión"
      redirect_to edit_password_user_path(auth_user)
    else
      @auth_user.password = params[:user][:password]
      @auth_user.password_confirmation = params[:user][:password_confirmation]

      if @auth_user.valid?
        @auth_user.encrypt_password

        if @auth_user.update_attributes(
            :password => @auth_user.password,
            :password_confirmation => @auth_user.password
          )

          flash[:notice] = "La contraseña ha sido modificada satisfactoriamente"
          redirect_to login_users_url
        else
          render :action => :edit_password
        end
      else
        render :action => :edit_password
      end

      @auth_user.password, @auth_user.password_confirmation = nil, nil
    end
  rescue ActiveRecord::StaleObjectError
    flash[:alert] = "Se produjo un error al modificar la contraseña"
    redirect_to edit_password_user_path(@auth_user)
  end
  
  # * GET /users/logout
  # * GET /users/logout.xml
  def logout
    restart_session
    redirect_to_login "La sesión se ha cerrado correctamente"
  end
  
end
