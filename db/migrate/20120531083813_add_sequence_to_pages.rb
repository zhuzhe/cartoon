class AddSequenceToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sequence, :integer, :default => 0

  end
end
