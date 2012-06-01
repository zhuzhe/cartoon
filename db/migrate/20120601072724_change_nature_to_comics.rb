class ChangeNatureToComics < ActiveRecord::Migration

	def change
		change_column_default :comics, :nature, 0
	end
end
