class ContractMailer < ActionMailer::Base
  default :from => "consultas_web@multisat.com.ar"
  
  def send_consultation(contract)
    @contract = contract
    mail(
      :to => contract.email, 
      :subject => 'Consulta de la web'
    )
  end
end
