require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  # Función para inicializar las variables utilizadas en las pruebas
  def setup
    @user = User.find users(:admin).id
  end

  # Prueba que se realicen las búsquedas como se espera
  test 'search' do
    assert_kind_of User, @user
    assert_equal users(:admin).name, @user.name
    assert_equal users(:admin).user, @user.user
    assert_equal users(:admin).password, @user.password
    assert_equal users(:admin).admin, @user.admin
  end
  
  # Prueba la creación de un usuario
  test 'create' do
    assert_difference 'User.count' do
      @user = User.create(
        :user => 'new_user',
        :name => 'New name',
        :password => 'new_password_123',
        :password_confirmation => 'new_password_123',
        :admin => true
      )
    end
  end

  # Prueba de actualización de un usuario
  test 'update' do
    assert_no_difference 'User.count' do
      assert @user.update_attributes(:user => 'updated_user'),
        @user.errors.full_messages.join('; ')
    end

    @user.reload
    assert_equal 'updated_user', @user.user
  end

  # Prueba de eliminación de usuarios
  test 'delete' do
    assert_difference('User.count', -1) { @user.destroy }
  end
  
  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates blank attributes' do
    @user.user = '   '
    @user.name = '   '

    assert @user.invalid?
    assert_equal 2, @user.errors.count
    assert_equal [error_message_from_model(@user, :user, :blank)],
      @user.errors[:user]
    assert_equal [error_message_from_model(@user, :name, :blank)],
      @user.errors[:name]
  end
  
  test 'validates unique attributes' do
    @user.user = users(:noadmin).user
    @user.name = users(:noadmin).name
    assert @user.invalid?
    assert_equal 2, @user.errors.count
    assert_equal [error_message_from_model(@user, :user, :taken)],
      @user.errors[:user]
    assert_equal [error_message_from_model(@user, :name, :taken)],
      @user.errors[:name]
  end
  
  test 'validates lenght attributes' do
    @user.user = 'abcd'
    @user.name = 'abcd'
    @user.password = 'a9A'
    assert @user.invalid?
    assert_equal 3, @user.errors.count
    assert_equal [error_message_from_model(@user, :user, :too_short,
      :count => 5)], @user.errors[:user]
    assert_equal [error_message_from_model(@user, :password, :too_short,
      :count => 5)], @user.errors[:password]
    assert_equal [error_message_from_model(@user, :name, :too_short,
      :count => 5)], @user.errors[:name]

    @user.user = 'abcd' * 10
    @user.password = 'admin_password' * 10
    @user.name = 'abcde' * 10
    assert @user.invalid?
    assert_equal 3, @user.errors.count
    assert_equal [error_message_from_model(@user, :user, :too_long,
      :count => 30)], @user.errors[:user]
    assert_equal [error_message_from_model(@user, :password, :too_long,
      :count => 128)], @user.errors[:password]
    assert_equal [error_message_from_model(@user, :name, :too_long,
      :count => 30)], @user.errors[:name]
  end

  # Prueba que las validaciones del modelo se cumplan como es esperado
  test 'validates confirmed attributes' do
    @user.password = 'admin123'
    @user.password_confirmation = 'admin125'
    assert @user.invalid?
    assert_equal 1, @user.errors.count
    assert_equal [error_message_from_model(@user, :password, :confirmation)],
      @user.errors[:password]
  end
end
