class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :owner
      t.string :message
      t.string :image_url

      t.timestamps null: false
    end
  end
end
