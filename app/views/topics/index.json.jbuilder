json.array!(@topics) do |topic|
  json.extract! topic, :id, :topic_name, :course_id
  json.url topic_url(topic, format: :json)
end
