require 'test_helper'

class ContactStatesControllerTest < ActionController::TestCase
  fixtures :contact_states
  
  setup do
    @contact_state = contact_states(:rellamar)
  end

  test "should get index" do
    perform_auth
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_states)
  end

  test "should get new" do
    perform_auth
    get :new
    assert_response :success
  end

  test "should create contact_state" do
    perform_auth
    assert_difference('ContactState.count') do
      post :create, :contact_state => {
        :state => 'new_state'
      }
    end

    assert_redirected_to contact_state_path(assigns(:contact_state))
  end

  test "should show contact_state" do
    perform_auth
    get :show, :id => @contact_state.to_param
    assert_response :success
  end

  test "should get edit" do
    perform_auth
    get :edit, :id => @contact_state.to_param
    assert_response :success
  end

  test "should update contact_state" do
    perform_auth
    put :update, :id => @contact_state.to_param, :contact_state => @contact_state.attributes
    assert_redirected_to contact_state_path(assigns(:contact_state))
  end

  test "should destroy contact_state" do
    perform_auth
    assert_difference('ContactState.count', -1) do
      delete :destroy, :id => @contact_state.to_param
    end

    assert_redirected_to contact_states_path
  end
end
