json.array!(@lesson_resopnses) do |lesson_resopnse|
  json.extract! lesson_resopnse, :id, :lesson_id, :user_id
  json.url lesson_resopnse_url(lesson_resopnse, format: :json)
end
