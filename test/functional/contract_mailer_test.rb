require 'test_helper'

class ContractMailerTest < ActionMailer::TestCase
  test 'Send consultation' do
    contract = Contract.new(:nombre => :Pepito, :dni => 30123456, 
      :telefono => 4440055, :interesado_en => DIRECTV_OPTIONS.first, 
      :email => 'pepito@gmail.com', :comentarios => 'Comentarios...')
    mail = ContractMailer.send_consultation(contract)
    assert_equal 'Consulta del sitio multisat', mail.subject
    assert_equal [contract.email], mail.to
    assert_equal ['soporte@multisat.com.ar'], mail.from
    assert_match "#{contract.nombre}", mail.body.encoded
 
    assert_difference 'ActionMailer::Base.deliveries.size' do
      mail.deliver
    end
  end
end
