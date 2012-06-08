class AddUpdateStatusToComics < ActiveRecord::Migration
  def change
    add_column :comics, :update_status, :integer

  end
end
