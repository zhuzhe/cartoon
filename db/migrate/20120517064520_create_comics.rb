class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name
      t.string :description
      t.string :cover
      t.string :pages

      t.timestamps
    end
  end
end
