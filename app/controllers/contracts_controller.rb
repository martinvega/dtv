class ContractsController < ApplicationController
  def new
    
    @contract = Contract.new
    
    respond_to do |format|
      format.html # new.html.erb
      
    end
  end

  def send_contact
    
    @contract = Contract.new(params)
    
    respond_to do |format|
      if @contract.valid?
        ContractMailer.send_consultation(@contract).deliver
        format.html {redirect_to login_users_path, 
          :notice => 'Su consulta ha sido enviada satisfactoriamente'
        }
      else
        format.html { render :action => "new" }
        format.json { render :json => @contract.errors, :status => :unprocessable_entity }
      end
    end
    
  end
end
