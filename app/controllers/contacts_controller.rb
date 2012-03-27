class ContactsController < ApplicationController
  before_filter :auth
  before_filter :admin, :only => [:new, :create, :import_csv, :import_csv_contacts]
  
  @state
  require 'csv'
  require 'iconv'
  # GET /contacts
  # GET /contacts.json
  def index
    if @auth_user.admin?
      if params[:state_id].present?
        @state = Contact.where(:contact_state_id => params[:state_id])
        @contacts = Contact.paginate(
        :page => params[:page],
        :per_page => 10
      ).where(:contact_state_id => params[:state_id])
      else
        @contacts = Contact.paginate(
        :page => params[:page],
        :per_page => 10
        )
      end
      
    else
      if params[:state_id].present?
        @contacts = Contact.where(:user_id => @auth_user.id, 
          :contact_state_id => params[:state_id]).paginate(
            :page => params[:page],
            :per_page => 10
            )        
      else
        @contacts = Contact.where(:user_id => @auth_user.id).paginate(
        :page => params[:page],
        :per_page => 10
        )        
      end
      
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contacts }
      format.pdf  {
        Contact.to_pdf(Contact.all)
        redirect_to "/#{Contact.pdf_relative_path}"
      }
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
    @contact.user = @auth_user
       
    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, :notice => 'El contacto ha sido creado satisfactoriamente' }
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
    @contact.user = @auth_user
       
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, :notice => 'El contacto ha sido actualizado satisfactoriamente' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def load_contacts
    
    unless params[:campaign].nil?
      @campaign = Campaign.find(params[:campaign])
      @selected = @campaign.id
      date = @campaign.date
      contact = Contact.where('contact_state_id IS NULL AND date BETWEEN :start AND :end',
        :start => date.beginning_of_month,
        :end => date.end_of_month).first!
      @contact = Contact.find(contact.id)
    end
      
  rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'No quedan mas contactos sin estado para la campaña seleccionada'
      redirect_to contacts_path  
    
  end
  
  def update_state
    @contact = Contact.find(params[:id])
           
    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        @contact.user = @auth_user
        format.html { 
          flash[:notice] = 'El estado ha sido guardado satisfactoriamente, 
          presione Buscar Contacto para continuar con la carga'
          render :action => :load_contacts }
        format.json { head :ok }
      else
        format.html { render :action => 'load_contacts' }
        format.json { render :json => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def import_csv
  end
  
  def import_csv_contacts
    if params[:dump_contacts] && File.extname(params[:dump_contacts][:file].original_filename).downcase == '.csv'
      @parsed_file=CSV::Reader.parse(params[:dump_contacts][:file], delimiter = ',')
      conv = Iconv.new('UTF-8//IGNORE//TRANSLIT', 'ISO-8859-15')
      n=0
      @parsed_file.each  do |row|
        c = Contact.new
        c.date = row[0].to_date
        c.name = conv.iconv(row[1].to_s)
        c.number = row[2].to_i
        c.locality = conv.iconv(row[3].to_s)
        if row[4]
          state = ContactState.find_by_state(conv.iconv(row[4].to_s.upcase))
          if state
            c.contact_state = state
          end
        end
        puts "DATE = #{c.date} / c.name #{c.name} / c.number = #{c.number} /
        c.locality = #{c.locality} / c.state = #{c.contact_state}"
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
