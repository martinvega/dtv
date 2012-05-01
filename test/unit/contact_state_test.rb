require 'test_helper'

class ContactStateTest < ActiveSupport::TestCase
  fixtures :contact_states

  # Función para inicializar las variables utilizadas en las pruebas
  def setup
    @state = ContactState.find contact_states(:rellamar).id
  end

  # Prueba que se realicen las búsquedas como se espera
  test 'search' do
    assert_kind_of ContactState, @state
    assert_equal contact_states(:rellamar).state, @state.state
  end
  
   # Prueba la creación de un usuario
  test 'create' do
    assert_difference 'ContactState.count' do
      @state = ContactState.create(
        :state => 'new_state'
      )
    end
  end

  # Prueba de actualización de un usuario
  test 'update' do
    assert_no_difference 'ContactState.count' do
      assert @state.update_attributes(:state => 'updated_state'),
        @state.errors.full_messages.join('; ')
    end

    @state.reload
    assert_equal 'updated_state', @state.state
  end

  # Prueba de eliminación de usuarios
  test 'delete' do
    assert_difference('ContactState.count', -1) { @state.destroy }
  end
  
  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates blank attributes' do
    @state.state = '   '
   
    assert @state.invalid?
    assert_equal 1, @state.errors.count
    assert_equal [error_message_from_model(@state, :state, :blank)],
      @state.errors[:state]
  end
  
  test 'validates unique attributes' do
    @state.state = contact_states(:nocontesta).state
    assert @state.invalid?
    assert_equal 1, @state.errors.count
    assert_equal [error_message_from_model(@state, :state, :taken)],
      @state.errors[:state]
  end
  
  test 'validates lenght attributes' do
    @state.state = 'abcd' * 10
    
    assert @state.invalid?
    assert_equal 1, @state.errors.count
    assert_equal [error_message_from_model(@state, :state, :too_long,
      :count => 30)], @state.errors[:state]
  end

  
end
