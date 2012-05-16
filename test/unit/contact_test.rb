require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  fixtures :contacts
  
  # Función para inicializar las variables utilizadas en las pruebas
  def setup
    @contact = Contact.find contacts(:david).id
  end
  
  # Prueba que se realicen las búsquedas como se espera
  test 'search' do
    assert_kind_of Contact, @contact
    assert_equal contacts(:david).name, @contact.name
    assert_equal contacts(:david).date, @contact.date
    assert_equal contacts(:david).number, @contact.number
    assert_equal contacts(:david).locality, @contact.locality
  end
  
  # Prueba la creación de un contacto
  test 'create' do
    assert_difference 'Contact.count' do
      @contact = Contact.create(
        :name => 'New name',
        :date => '2012-10-10',
        :number => '123',
        :locality => 'New Locality'      
      )
    end
  end

  # Prueba de actualización de un contacto
  test 'update' do
    assert_no_difference 'Contact.count' do
      assert @contact.update_attributes(:name => 'updated_name'),
        @contact.errors.full_messages.join('; ')
    end

    @contact.reload
    assert_equal 'updated_name', @contact.name
  end

  # Prueba de eliminación de contactos
  test 'delete' do
    assert_difference('Contact.count', -1) { @contact.destroy }
  end
  
  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates blank attributes' do
    @contact.name = '   '
    @contact.number = '   '
    assert @contact.invalid?
    assert_equal 2, @contact.errors.count
    assert_equal [error_message_from_model(@contact, :name, :blank)],
      @contact.errors[:name]
    assert_equal [error_message_from_model(@contact, :number, :blank)],
      @contact.errors[:number]
  end
  
  test 'validates unique attributes' do
    @contact.number = contacts(:pablo).number
    @contact.name = contacts(:pablo).name
    assert @contact.invalid?
    assert_equal 2, @contact.errors.count
    assert_equal [error_message_from_model(@contact, :number, :taken)],
      @contact.errors[:number]
    assert_equal [error_message_from_model(@contact, :name, :taken)],
      @contact.errors[:name]
  end
  
  test 'validates lenght attributes' do
    @contact.name = 'contact_name' * 12
    @contact.locality = 'locality' * 20
    @contact.comment = 'contact_comment' * 20
    assert @contact.invalid?
    assert_equal 3, @contact.errors.count
    assert_equal [error_message_from_model(@contact, :name, :too_long,
      :count => 128)], @contact.errors[:name]
    assert_equal [error_message_from_model(@contact, :locality, :too_long,
      :count => 128)], @contact.errors[:locality]
    assert_equal [error_message_from_model(@contact, :comment, :too_long,
      :count => 255)], @contact.errors[:comment]
  end
  
  test 'conversion to pdf' do
    FileUtils.rm Contact.pdf_full_path if File.exists?(Contact.pdf_full_path)

    assert !File.exists?(Contact.pdf_full_path)

    assert_nothing_raised(Exception) do
      contacts << @contact
      Contact.to_pdf contacts
    end

    assert File.exists?(Contact.pdf_full_path)

    FileUtils.rm Contact.pdf_full_path
  end
  
end
