class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.integer   :turn_id,       null: false
      t.integer   :field_id,      null: false
      t.integer   :order_number,  null: false
      t.string    :player_name_1, null: false
      t.string    :belongs_1,     null: false
      t.integer   :score_1
      t.string    :player_name_2
      t.string    :belongs_2
      t.integer   :score_2
      t.text      :log

      t.references :user,         null: false, foreign_key: true
      t.references :event,        null: false, foreign_key: true

      t.timestamps
    end
  end
end
