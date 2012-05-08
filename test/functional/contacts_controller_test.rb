require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  fixtures :contacts
  
  setup do
    @contact = Contact.find(contacts(:david).id)
  end

  test "should get index" do
    perform_auth
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    perform_auth
    get :new
    assert_response :success
  end

  test "should create contact" do
    perform_auth
    assert_difference('Contact.count') do
      post :create, :contact => {
        :name => 'New name',
        :date => '2012-10-10',
        :number => '123',
        :locality => 'New Locality'   
      }
    end

    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should show contact" do
    perform_auth
    get :show, :id => @contact.to_param
    assert_response :success
  end

  test "should get edit" do
    perform_auth
    get :edit, :id => @contact.to_param
    assert_response :success
  end

  test "should update contact" do
    perform_auth
    put :update, :id => @contact.to_param, :contact => @contact.attributes
    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should destroy contact" do
    perform_auth
    assert_difference('Contact.count', -1) do
      delete :destroy, :id => @contact.to_param
    end

    assert_redirected_to contacts_path
  end
end
