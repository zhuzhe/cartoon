require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get latest" do
    get :latest
    assert_response :success
  end

  test "should get hot" do
    get :hot
    assert_response :success
  end

end
