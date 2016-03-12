json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :email, :password_digest, :phone, :user_role
  json.url user_url(user, format: :json)
end
