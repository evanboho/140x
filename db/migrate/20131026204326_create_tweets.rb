class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :body
      t.integer :tweeter_id
      t.integer :sender_id
      t.string :tweet_uid

      t.timestamps
    end
    add_index :tweets, :tweeter_id
    add_index :tweets, :sender_id
  end
end
