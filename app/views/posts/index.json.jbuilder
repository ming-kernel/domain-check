json.array!(@posts) do |post|
  json.extract! post, :title, :cotent
  json.url post_url(post, format: :json)
end
