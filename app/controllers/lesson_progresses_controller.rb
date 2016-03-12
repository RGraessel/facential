class LessonProgressesController < ApplicationController
  before_action :set_lesson_progress, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  before_action :verify_ownership, only: [:show, :edit, :update, :destroy]

  # GET /lesson_progresses
  # GET /lesson_progresses.json
  def index
    @lesson_progresses = LessonProgress.all.where(user_id: current_user.id)
  end

  # GET /lesson_progresses/1
  # GET /lesson_progresses/1.json
  def show
  end

  # GET /lesson_progresses/new
  def new
    @lesson_progress = LessonProgress.new
  end

  # GET /lesson_progresses/1/edit
  def edit
  end

  # POST /lesson_progresses
  # POST /lesson_progresses.json
  def create
    @lesson_progress = LessonProgress.new(lesson_progress_params)

    respond_to do |format|
      if @lesson_progress.save
        format.html { redirect_to @lesson_progress, notice: 'Lesson progress was successfully created.' }
        format.json { render :show, status: :created, location: @lesson_progress }
      else
        format.html { render :new }
        format.json { render json: @lesson_progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lesson_progresses/1
  # PATCH/PUT /lesson_progresses/1.json
  def update
    respond_to do |format|
      if @lesson_progress.update(lesson_progress_params)
        format.html { redirect_to @lesson_progress, notice: 'Lesson progress was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson_progress }
      else
        format.html { render :edit }
        format.json { render json: @lesson_progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_progresses/1
  # DELETE /lesson_progresses/1.json
  def destroy
    @lesson_progress.destroy
    respond_to do |format|
      format.html { redirect_to lesson_progresses_url, notice: 'Lesson progress was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson_progress
      @lesson_progress = LessonProgress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_progress_params
      params.require(:lesson_progress).permit(:lesson_id, :user_id)
    end
end
