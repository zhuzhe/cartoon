require 'test_helper'

class QuencesControllerTest < ActionController::TestCase
  setup do
    @quence = quences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quence" do
    assert_difference('Quence.count') do
      post :create, :quence => @quence.attributes
    end

    assert_redirected_to quence_path(assigns(:quence))
  end

  test "should show quence" do
    get :show, :id => @quence
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @quence
    assert_response :success
  end

  test "should update quence" do
    put :update, :id => @quence, :quence => @quence.attributes
    assert_redirected_to quence_path(assigns(:quence))
  end

  test "should destroy quence" do
    assert_difference('Quence.count', -1) do
      delete :destroy, :id => @quence
    end

    assert_redirected_to quences_path
  end
end
