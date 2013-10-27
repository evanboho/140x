class Tweet < ActiveRecord::Base
  belongs_to :tweeter

  def href
    "https://twitter.com/#{tweeter.screen_name}" + (!tweet_uid.nil? ? "/status/#{tweet_uid}" : "")
  end

end
