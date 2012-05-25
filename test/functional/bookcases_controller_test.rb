require 'test_helper'

class BookcasesControllerTest < ActionController::TestCase
  setup do
    @bookcase = bookcases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookcases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookcase" do
    assert_difference('Bookcase.count') do
      post :create, :bookcase => @bookcase.attributes
    end

    assert_redirected_to bookcase_path(assigns(:bookcase))
  end

  test "should show bookcase" do
    get :show, :id => @bookcase
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @bookcase
    assert_response :success
  end

  test "should update bookcase" do
    put :update, :id => @bookcase, :bookcase => @bookcase.attributes
    assert_redirected_to bookcase_path(assigns(:bookcase))
  end

  test "should destroy bookcase" do
    assert_difference('Bookcase.count', -1) do
      delete :destroy, :id => @bookcase
    end

    assert_redirected_to bookcases_path
  end
end
