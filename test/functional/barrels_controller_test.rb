require 'test_helper'

class BarrelsControllerTest < ActionController::TestCase
  setup do
    @barrel = barrels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:barrels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create barrel" do
    assert_difference('Barrel.count') do
      post :create, barrel: { container: @barrel.container, contents: @barrel.contents, gallons: @barrel.gallons }
    end

    assert_redirected_to barrel_path(assigns(:barrel))
  end

  test "should show barrel" do
    get :show, id: @barrel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @barrel
    assert_response :success
  end

  test "should update barrel" do
    put :update, id: @barrel, barrel: { container: @barrel.container, contents: @barrel.contents, gallons: @barrel.gallons }
    assert_redirected_to barrel_path(assigns(:barrel))
  end

  test "should destroy barrel" do
    assert_difference('Barrel.count', -1) do
      delete :destroy, id: @barrel
    end

    assert_redirected_to barrels_path
  end
end
