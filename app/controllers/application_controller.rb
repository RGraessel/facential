require "opentok"
OPENTOK_KEY = ENV["tok_box_api_key"]
OPENTOK_SECRET = ENV["tok_box_secret"]


class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end


    def session_action
      opentok = OpenTok::OpenTok.new OPENTOK_KEY, OPENTOK_SECRET
      @session = opentok.create_session :media_mode => :routed
      session_id = @session.session_id
      token = opentok.generate_token session_id

      render json: {
        :api_key => OPENTOK_KEY,
        :session_id => session_id,
        :token => token
      }.to_json

    end

    def start_recording
      opentok = OpenTok::OpenTok.new OPENTOK_KEY, OPENTOK_SECRET
      session_id = params[:session_id]
      archive = opentok.archives.create session_id, :name => "Important Presentation"
      current_lesson = Lesson.find(params[:lesson_id])

      user_response = LessonResponse.new(
        lesson: current_lesson,
        user: current_user,
        archive_id: archive.id,
        session_id: session_id,
      )

      if user_response.save
        render json: {id: archive.id}
      else
        render json: {id: 'UNKNOWN'}
      end
    end

    def stop_recording
      opentok = OpenTok::OpenTok.new OPENTOK_KEY, OPENTOK_SECRET
      archive_id = params[:archive_id]
      opentok.archives.stop_by_id archive_id
      render json: {id: archive_id}
    end

    def view_archived_video
      sleep 2
      opentok = OpenTok::OpenTok.new OPENTOK_KEY, OPENTOK_SECRET
      archive_id = params[:archive_id]
      current_lesson_response = LessonResponse.find_by(archive_id: archive_id)
      archive = opentok.archives.find archive_id
      current_lesson_response.recording_url = archive.url

      render json: archive.url
    end

    def rerecord
      archive = LessonResponse.find_by(archive_id: params[:archive_id])
      archive.destroy
      respond_to do |format|
        format.json { render json: archive, status: :ok }
      end
      last_five = LessonResponse.last(5).reverse
    end

    def submit
      video_submission = LessonResponse.find_by(archive_id: params[:archive_id])

      latest_submission = video_submission.update(marked_as_complete: true)

      redirect_to "/users/#{current_user.id}"
    end

end
