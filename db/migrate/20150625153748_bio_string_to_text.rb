class BioStringToText < ActiveRecord::Migration
  def change
    remove_column :users, :bio
    add_column :users, :bio, :text
  end
end
