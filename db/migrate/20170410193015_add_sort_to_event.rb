class AddSortToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :sort_order, :integer, default: 0
  end
end
