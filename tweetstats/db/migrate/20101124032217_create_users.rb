class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :twitter_id
      t.string :screen_name
      t.string :token
      t.string :secret
      t.string :profile_image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
