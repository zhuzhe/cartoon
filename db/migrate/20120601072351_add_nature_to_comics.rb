class AddNatureToComics < ActiveRecord::Migration
  def change
    add_column :comics, :nature, :integer

  end
end
