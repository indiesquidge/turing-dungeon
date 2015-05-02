class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :message
      t.string :sha
      t.string :repo

      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
