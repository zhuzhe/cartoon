class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :url
      t.integer :comic_id

      t.timestamps
    end
  end
end
