class LessonResponseController < ApplicationController
  before_action :set_lesson_response, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  # before_action :verify_ownership, only: [:show, :edit, :update, :destroy]

  # GET /lesson_responses
  # GET /lesson_responses.json
  def index
    @lesson_responses = LessonResponse.all.where(user_id: current_user.id)
  end

  # GET /lesson_responses/1
  # GET /lesson_responses/1.json
  def show
  end

  # GET /lesson_responses/new
  def new
    @lesson_response = LessonResponse.new
  end

  # GET /lesson_responses/1/edit
  def edit
  end

  # POST /lesson_responses
  # POST /lesson_responses.json
  def create
    @lesson_response = LessonResponse.new(lesson_response_params)

    respond_to do |format|
      if @lesson_response.save
        format.html { redirect_to @lesson_response, notice: 'Lesson response was successfully created.' }
        format.json { render :show, status: :created, location: @lesson_response }
      else
        format.html { render :new }
        format.json { render json: @lesson_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lesson_responses/1
  # PATCH/PUT /lesson_responses/1.json
  def update
    respond_to do |format|
      if @lesson_response.update(lesson_response_params)
        format.html { redirect_to @lesson_response, notice: 'Lesson response was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson_response }
      else
        format.html { render :edit }
        format.json { render json: @lesson_response.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_responses/1
  # DELETE /lesson_responses/1.json
  def destroy
    @lesson_response.destroy
    respond_to do |format|
      format.html { redirect_to lesson_responses_url, notice: 'Lesson response was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson_response
      @lesson_response = LessonResponse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_response_params
      params.require(:lesson_response).permit(:lesson_id, :user_id)
    end
end
