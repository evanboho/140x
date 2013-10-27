class Tweeter < ActiveRecord::Base
  has_many :grants, foreign_key: :granter_id, dependent: :destroy
  has_many :privileges, foreign_key: :grantee_id, class_name: "Grant"
  has_many :tweets, foreign_key: :sender_id
  has_many :as_you_tweets, foreign_key: :tweeter_id, class_name: "Tweet"
  validates_presence_of :screen_name
  validates_uniqueness_of :screen_name

  def update_with_auth_hash(hash)
    self.screen_name = hash[:info][:nickname]
    self.oauth_token = hash[:credentials][:token]
    self.oauth_secret = hash[:credentials][:secret]
    self.timezone = hash[:extra][:raw_info][:time_zone]
    self.save
  end

  def accounts_for_select
    accounts = [self] + privileges.collect(&:granter)
    accounts.collect { |a| [a.screen_name, a.id] }
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key    = Settings.service_field("twitter", "key")
      config.consumer_secret = Settings.service_field("twitter", "secret")
      config.access_token        = oauth_token
      config.access_token_secret = oauth_secret
    end
    @client
  end

end
