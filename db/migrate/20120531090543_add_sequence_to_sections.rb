class AddSequenceToSections < ActiveRecord::Migration
  def change
    add_column :sections, :sequence, :integer, :default => 0

  end
end
