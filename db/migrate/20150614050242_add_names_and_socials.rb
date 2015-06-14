class AddNamesAndSocials < ActiveRecord::Migration
  def change
    add_column :users, :first_name,       :string
    add_column :users, :last_name,        :string
    add_column :users, :linkedin,         :string
    add_column :users, :twitter,          :string
    add_column :users, :current_employer, :string
  end
end
