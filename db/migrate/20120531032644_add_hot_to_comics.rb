class AddHotToComics < ActiveRecord::Migration
  def change
    add_column :comics, :hot, :integer

  end
end
