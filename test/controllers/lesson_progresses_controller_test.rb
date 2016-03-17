require 'test_helper'

class LessonResponsesControllerTest < ActionController::TestCase
  setup do
    @lesson_response = lesson_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lesson_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lesson_response" do
    assert_difference('LessonResponse.count') do
      post :create, lesson_response: { lesson_id: @lesson_response.lesson_id, user_id: @lesson_response.user_id }
    end

    assert_redirected_to lesson_response_path(assigns(:lesson_response))
  end

  test "should show lesson_response" do
    get :show, id: @lesson_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lesson_response
    assert_response :success
  end

  test "should update lesson_response" do
    patch :update, id: @lesson_response, lesson_response: { lesson_id: @lesson_response.lesson_id, user_id: @lesson_response.user_id }
    assert_redirected_to lesson_response_path(assigns(:lesson_response))
  end

  test "should destroy lesson_response" do
    assert_difference('LessonResponse.count', -1) do
      delete :destroy, id: @lesson_response
    end

    assert_redirected_to lesson_responses_path
  end
end
