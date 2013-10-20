json.array!(@tweeters) do |tweeter|
  json.extract! tweeter, :handle, :oauth_token
  json.url tweeter_url(tweeter, format: :json)
end
