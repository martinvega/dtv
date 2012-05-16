class ContractMailer < ActionMailer::Base
  default :from => 'soporte@multisat.com.ar'
  
  def send_consultation(contract)
    @contract = contract
    mail(
      :to => contract.email, 
      :subject => 'Consulta del sitio multisat'
    )
  end
end
