class CreateQuences < ActiveRecord::Migration
  def change
    create_table :quences do |t|
      t.integer :comic_id

      t.timestamps
    end
  end
end
