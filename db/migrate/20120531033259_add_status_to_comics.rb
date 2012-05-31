class AddStatusToComics < ActiveRecord::Migration
  def change
    add_column :comics, :status, :integer, :default => 0
  end
end
