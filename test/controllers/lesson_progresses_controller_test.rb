require 'test_helper'

class LessonProgressesControllerTest < ActionController::TestCase
  setup do
    @lesson_progress = lesson_progresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lesson_progresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lesson_progress" do
    assert_difference('LessonProgress.count') do
      post :create, lesson_progress: { lesson_id: @lesson_progress.lesson_id, user_id: @lesson_progress.user_id }
    end

    assert_redirected_to lesson_progress_path(assigns(:lesson_progress))
  end

  test "should show lesson_progress" do
    get :show, id: @lesson_progress
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lesson_progress
    assert_response :success
  end

  test "should update lesson_progress" do
    patch :update, id: @lesson_progress, lesson_progress: { lesson_id: @lesson_progress.lesson_id, user_id: @lesson_progress.user_id }
    assert_redirected_to lesson_progress_path(assigns(:lesson_progress))
  end

  test "should destroy lesson_progress" do
    assert_difference('LessonProgress.count', -1) do
      delete :destroy, id: @lesson_progress
    end

    assert_redirected_to lesson_progresses_path
  end
end
