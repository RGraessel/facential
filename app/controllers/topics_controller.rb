class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]
  before_action :authorize
  # GET /topics
  # GET /topics.json
  def index
    @topics = current_user.topics.where(course_id: params[:course_id])
    @courses = current_user.courses.where(course_id: params[:course_id])
    @users = current_user.id
    @user_course = current_user.courses.each{|f| f}.first.id
    @user_topics = current_user.topics.each{|f| f}.first.id
    @topic_progress = {}
    @topic_lesson_count = {}
    @progress = {}

    current_user.topics.each do |topic|
      @topic_progress[topic] = 0
      @topic_lesson_count[topic] = 0
      topic.lessons.each do |lesson|
        @topic_lesson_count[topic] +=1
        lesson.lesson_responses.each do |lr|
          if lr.marked_as_complete == true && lr.user_id == current_user.id
            @topic_progress[topic] += 1
          end
        end
      end
      if @topic_lesson_count[topic] > 0
        @progress[topic] = ((@topic_progress[topic] / @topic_lesson_count[topic].to_f).round(2) * 100)
      else
        @progress[topic] = 0
      end
    end

  end

  def all_topics
    @topics = current_user.topics
    @user_course = current_user.courses.each{|f| f}.first.id
    @user_topics = current_user.topics.each{|f| f}.first.id
    @topic_progress = {}
    @topic_lesson_count = {}
    @progress = {}

    current_user.topics.each do |topic|
      @topic_progress[topic] = 0
      @topic_lesson_count[topic] = 0
      topic.lessons.each do |lesson|
        @topic_lesson_count[topic] +=1
        lesson.lesson_responses.each do |lr|
          if lr.marked_as_complete == true && lr.user_id == current_user.id
            @topic_progress[topic] += 1
          end
        end
      end
      if @topic_lesson_count[topic] > 0
        @progress[topic] = ((@topic_progress[topic] / @topic_lesson_count[topic].to_f).round(2) * 100)
      else
        @progress[topic] = 0
      end
    end

    render :index
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @course = Course.find(params[:course_id])
    @topics = current_user.topics.where(course_id: params[:course_id])

  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }

      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    def validator
      if current_user.courses.include? Course.find(params[:course_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:topic_name, :course_id)
    end
end
