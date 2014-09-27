require 'test_helper'

class LinestudiesControllerTest < ActionController::TestCase
  setup do
    @linestudy = linestudies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:linestudies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create linestudy" do
    assert_difference('Linestudy.count') do
      post :create, linestudy: { description: @linestudy.description, end_time: @linestudy.end_time, name: @linestudy.name, start_time: @linestudy.start_time, type: @linestudy.type, user_id: @linestudy.user_id }
    end

    assert_redirected_to linestudy_path(assigns(:linestudy))
  end

  test "should show linestudy" do
    get :show, id: @linestudy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @linestudy
    assert_response :success
  end

  test "should update linestudy" do
    patch :update, id: @linestudy, linestudy: { description: @linestudy.description, end_time: @linestudy.end_time, name: @linestudy.name, start_time: @linestudy.start_time, type: @linestudy.type, user_id: @linestudy.user_id }
    assert_redirected_to linestudy_path(assigns(:linestudy))
  end

  test "should destroy linestudy" do
    assert_difference('Linestudy.count', -1) do
      delete :destroy, id: @linestudy
    end

    assert_redirected_to linestudies_path
  end
end
