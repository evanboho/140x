class CreateTweeters < ActiveRecord::Migration
  def change
    create_table :tweeters do |t|
      t.string :screen_name
      t.string :oauth_token
      t.string :oauth_secret
      t.string :timezone

      t.timestamps
    end
    add_index :tweeters, :screen_name
  end
end
