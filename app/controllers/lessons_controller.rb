# require "opentok"
# OPENTOK_KEY = ENV["tok_box_api_key"]
# OPENTOK_SECRET = ENV["tok_box_secret"]


class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  # before_action :verify_ownership, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = current_user.lessons.where(topic_id: params[:topic_id])
    @topics = current_user.topics.where(course_id: params[:course_id])
    @courses = current_user.courses

    @completed = {}
    # @last_archive_id = current_user.lesson_responses.last.archive_id
    current_user.lessons.each do |lesson|
      @completed[lesson] = 0
      lesson.lesson_responses.each do |lr|
        if lr.marked_as_complete == true && lr.user_id == current_user.id
          @completed[lesson] += 1
        end
      end
    end

  end

  def all_lessons
    @completed = {}
    # @last_archive_id = current_user.lesson_responses.last.archive_id
    current_user.lessons.each do |lesson|
      @completed[lesson] = 0
      lesson.lesson_responses.each do |lr|
        if lr.marked_as_complete == true && lr.user_id == current_user.id
          @completed[lesson] += 1
        end
      end
    end

    @lessons = current_user.lessons
    render :index
  end


  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @courses = current_user.courses
    @topics = current_user.topics.where(course_id: params[:course_id])
    @lessons = current_user.lessons.where(topic_id: params[:topic_id])
    @user_course = current_user.courses.each{|f| f}.first.id
    @user_topics = current_user.topics.each{|f| f}.first.id
    @lesson = Lesson.find(params[:id])
  end

  # def session_action
  #   opentok = OpenTok::OpenTok.new OPENTOK_KEY, OPENTOK_SECRET
  #   @session = opentok.create_session :media_mode => :routed
  #   session_id = @session.session_id
  #   token = opentok.generate_token session_id
  #
  #   render json: {
  #     :api_key => OPENTOK_KEY,
  #     :session_id => session_id,
  #     :token => token
  #   }.to_json
  #
  # end
  #
  # def start_recording
  #   opentok = OpenTok::OpenTok.new OPENTOK_KEY, OPENTOK_SECRET
  #   session_id = params[:session_id]
  #   archive = opentok.archives.create session_id, :name => "Important Presentation"
  #   current_lesson = Lesson.find(params[:lesson_id])
  #
  #   user_response = LessonResponse.new(
  #     lesson: current_lesson,
  #     user: current_user,
  #     archive_id: archive.id,
  #     session_id: session_id,
  #   )
  #
  #   if user_response.save
  #     render json: {id: archive.id}
  #   else
  #     render json: {id: 'UNKNOWN'}
  #   end
  # end

  # def stop_recording
 #   opentok = OpenTok::OpenTok.new OPENTOK_KEY, OPENTOK_SECRET
 #   archive_id = params[:archive_id]
 #   opentok.archives.stop_by_id archive_id
 #   render json: {id: archive_id}
 # end
 #
 # def view_archived_video
 #   sleep 2
 #   opentok = OpenTok::OpenTok.new OPENTOK_KEY, OPENTOK_SECRET
 #   archive_id = params[:archive_id]
 #   current_lesson_response = LessonResponse.find_by(archive_id: archive_id)
 #   archive = opentok.archives.find archive_id
 #   current_lesson_response.recording_url = archive.url
 #
 #   render json: archive.url
 # end
 #
 # def rerecord
 #   archive = LessonResponse.find_by(archive_id: params[:archive_id])
 #   archive.destroy
 #   respond_to do |format|
 #     format.json { render json: archive, status: :ok }
 #   end
 #   last_five = LessonResponse.last(5).reverse
 # end
 #
 # def submit
 #   video_submission = LessonResponse.find_by(archive_id: params[:archive_id])
 #
 #   latest_submission = video_submission.update(marked_as_complete: true)
 #
 #   redirect_to user_courses_path(current_user)
 #
 # end
 # GET /lessons/new
 def new
   @lesson = Lesson.new
 end

 # GET /lessons/1/edit
 def edit
 end

 # POST /lessons
 # POST /lessons.json
 def create
   @lesson = Lesson.new(lesson_params)

   respond_to do |format|
     if @lesson.save
       format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
       format.json { render :show, status: :created, location: @lesson }
     else
       format.html { render :new }
       format.json { render json: @lesson.errors, status: :unprocessable_entity }
     end
   end
 end

 # PATCH/PUT /lessons/1
 # PATCH/PUT /lessons/1.json
 def update
   respond_to do |format|
     if @lesson.update(lesson_params)
       format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
       format.json { render :show, status: :ok, location: @lesson }
     else
       format.html { render :edit }
       format.json { render json: @lesson.errors, status: :unprocessable_entity }
     end
   end
 end

 # DELETE /lessons/1
 # DELETE /lessons/1.json
 def destroy
   @lesson.destroy
   respond_to do |format|
     format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
     format.json { head :no_content }
   end
 end

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_lesson
     @lesson = Lesson.find(params[:id])
   end

   # Never trust parameters from the scary internet, only allow the white list through.
   def lesson_params
     params.require(:lesson).permit(:lesson_name, :lesson_description, :lesson_objective, :topic_id)
   end
end
