class AddViewCountToEntrys < ActiveRecord::Migration
  def change
    add_column :entries, :view_count, :integer, :default => 0
  end
end
