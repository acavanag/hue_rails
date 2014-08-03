require 'test_helper'

class LightsControllerTest < ActionController::TestCase
  setup do
    @light = lights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create light" do
    assert_difference('Light.count') do
      post :create, light: { key: @light.key, name: @light.name }
    end

    assert_redirected_to light_path(assigns(:light))
  end

  test "should show light" do
    get :show, id: @light
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @light
    assert_response :success
  end

  test "should update light" do
    patch :update, id: @light, light: { key: @light.key, name: @light.name }
    assert_redirected_to light_path(assigns(:light))
  end

  test "should destroy light" do
    assert_difference('Light.count', -1) do
      delete :destroy, id: @light
    end

    assert_redirected_to lights_path
  end
end
