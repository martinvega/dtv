class ContactsController < ApplicationController
  before_filter :auth
  require 'csv'
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])
    
    if @contact.comment.present?
      @contact.user = @auth_user
    end
    
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, :notice => 'Contact was successfully created.' }
        format.json { render :json => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.json { render :json => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])

    if @contact.comment.present?
      @contact.user = @auth_user
    end
    
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, :notice => 'Contact was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def import_csv
  end
  
  def import_csv_contacts
    if params[:dump_contacts] && File.extname(params[:dump_contacts][:file].original_filename).downcase == '.csv'
      @parsed_file=CSV::Reader.parse(params[:dump_questions][:file], delimiter = ';')
      n=0
      @parsed_file.each  do |row|
        c = Contact.new
        c.date = row[0]
        c.name = row[1]
        c.number = row[2]
        c.locality = row[3]
        cs = ContactState.new
        cs.state = row[4]
        # cs.comment = row[5]
        c.contact_state = cs
        if c.save
        n+=1
        end
      end
      flash[:notice] = "Se han importado #{n} contactos satisfactoriamente"
    else
      flash[:alert] = "Error: el archivo debe ser de tipo CSV"
    end
    respond_to do |format|
      format.html { redirect_to(contacts_path) }
    end
  end  

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :ok }
    end
  end
end
