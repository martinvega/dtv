require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures :users
  
  setup do
    @user = users(:admin)
  end

  test "should get index" do
    perform_auth
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    perform_auth
    get :new
    assert_response :success
  end

  test "should create user" do
    perform_auth
    assert_difference('User.count') do
      post :create, :user => {
        :user => 'new_user',
        :name => 'New name',
        :password => 'new_password_123',
        :password_confirmation => 'new_password_123',
        :admin => true
      }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    perform_auth
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    perform_auth
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    perform_auth
    put :update, :id => @user.to_param, :user => @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    perform_auth
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.to_param
    end

    assert_redirected_to users_path
  end
end
