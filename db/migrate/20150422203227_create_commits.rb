class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.references :user, index: true, foreign_key: true
      t.string :message
      t.string :repo

      t.timestamps null: false
    end
  end
end
