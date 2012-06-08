class ChangeUpdateStatusDefaultToComics < ActiveRecord::Migration
  def change
  	change_column_default :comics, :update_status, 0
  end
end
