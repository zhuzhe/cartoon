class CreateBookcases < ActiveRecord::Migration
  def change
    create_table :bookcases do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
