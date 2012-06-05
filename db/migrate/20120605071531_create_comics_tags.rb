class CreateComicsTags < ActiveRecord::Migration

	def change
		create_table :comics_tags do |t|
			t.integer :comic_id
			t.integer :tag_id

			t.timestamps
		end
	end
end
