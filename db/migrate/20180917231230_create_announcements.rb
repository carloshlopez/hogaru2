class CreateAnnouncements < ActiveRecord::Migration[5.1]
  def change
    create_table :announcements do |t|
      t.text :text, limit: 140
      t.datetime :expiration_date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
