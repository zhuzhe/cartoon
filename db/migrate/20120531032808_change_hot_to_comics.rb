class ChangeHotToComics < ActiveRecord::Migration

	def change
		change_column_default :comics, :hot, 0
	end
	
end
