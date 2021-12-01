class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string     :event_title,   null: false
      t.string     :place,         null: false
      t.integer    :prefecture_id, null: false
      t.date       :date,          null: false
      t.integer    :genre_id,      null: false
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
