Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Settings.service_field("twitter", "key"), Settings.service_field("twitter", "secret")
end
