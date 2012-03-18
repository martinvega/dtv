class ContactStatesController < ApplicationController
  before_filter :auth
  # GET /contact_states
  # GET /contact_states.json
  def index
    @contact_states = ContactState.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contact_states }
    end
  end

  # GET /contact_states/1
  # GET /contact_states/1.json
  def show
    @contact_state = ContactState.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contact_state }
    end
  end

  # GET /contact_states/new
  # GET /contact_states/new.json
  def new
    @contact_state = ContactState.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contact_state }
    end
  end

  # GET /contact_states/1/edit
  def edit
    @contact_state = ContactState.find(params[:id])
  end

  # POST /contact_states
  # POST /contact_states.json
  def create
    @contact_state = ContactState.new(params[:contact_state])

    respond_to do |format|
      if @contact_state.save
        format.html { redirect_to @contact_state, :notice => 'Contact state was successfully created.' }
        format.json { render :json => @contact_state, :status => :created, :location => @contact_state }
      else
        format.html { render :action => "new" }
        format.json { render :json => @contact_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contact_states/1
  # PUT /contact_states/1.json
  def update
    @contact_state = ContactState.find(params[:id])

    respond_to do |format|
      if @contact_state.update_attributes(params[:contact_state])
        format.html { redirect_to @contact_state, :notice => 'Contact state was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contact_state.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_states/1
  # DELETE /contact_states/1.json
  def destroy
    @contact_state = ContactState.find(params[:id])
    @contact_state.destroy

    respond_to do |format|
      format.html { redirect_to contact_states_url }
      format.json { head :ok }
    end
  end
end
