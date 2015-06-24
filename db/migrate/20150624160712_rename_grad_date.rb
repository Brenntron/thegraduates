class RenameGradDate < ActiveRecord::Migration
  def change
    remove_column :users, :graudation_date
    add_column :users, :graduation_date, :date
  end
end
