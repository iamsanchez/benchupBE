class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.references :gym, foreign_key: true
      t.integer :event_type
      t.string :image

      t.timestamps
    end
  end
end
