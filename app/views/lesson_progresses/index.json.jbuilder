json.array!(@lesson_progresses) do |lesson_progress|
  json.extract! lesson_progress, :id, :lesson_id, :user_id
  json.url lesson_progress_url(lesson_progress, format: :json)
end
