class ChangePagesToComic < ActiveRecord::Migration
  def up
  	remove_column :comics, :pages
  	add_column :comics, :sections, :string
  end

  def down
  	remove_column :comics, :sections
  	add_column :comics, :pages, :string
  end
end
