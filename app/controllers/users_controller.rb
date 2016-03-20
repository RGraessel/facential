class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # before_action :authorize
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    @topics = current_user.topics
    @lessons = current_user.lessons
    @courses = current_user.courses
    @user_course = current_user.courses.each{|f| f}.first.id
    @user_topics = current_user.topics.each{|f| f}.first.id
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user_course = current_user.courses.each{|f| f}.first.id
    @user_topics = current_user.topics.each{|f| f}.first.id
    @avatar = User.limit(1).all
    def lesson_completed
      @completed = []
      current_user.lessons.each do |lesson|
        lesson.lesson_responses.each do |lr|
          if lr = true && lr.user_id = current_user.id
            @completed << lesson
          end
        end
      end
      @completed
    end
  end

  # GET /users/new
  def new
    @user = User.new
    @avatar = User.new
  end

  # GET /users/1/edit
  def edit
     @avatar = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.avatar = nil
    @user.save
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # def has_attached_file
  #
  #   avatar_file_name
  #   avatar_file_size
  #   avatar_content_type
  #   avatar_updated_at
  #
  # end
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone, :user_role, :avatar)
  end
end
