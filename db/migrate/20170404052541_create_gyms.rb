class CreateGyms < ActiveRecord::Migration[5.0]
  def change
    create_table :gyms do |t|
      t.string :name
      t.string :description
      t.string :email
      t.string :logo

      t.timestamps
    end
    
	create_join_table :gyms, :users do |t|
	  t.index :gym_id
	  t.index :user_id
	end
  end
end
