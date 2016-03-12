json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :lesson_name, :lesson_description, :lesson_objective, :topic_id
  json.url lesson_url(lesson, format: :json)
end
