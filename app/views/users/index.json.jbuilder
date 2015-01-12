json.array!(@users) do |user|
  json.extract! user, :id, :name, :customizations, :preferences
  json.url user_url(user, format: :json)
end
