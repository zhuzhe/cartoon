class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :bookcase_id
      t.integer :comic_id

      t.timestamps
    end
  end
end
