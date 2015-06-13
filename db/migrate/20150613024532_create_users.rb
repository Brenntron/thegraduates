class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :linkedin
      t.string :twitter
      t.string :current_employer

      t.timestamps null: false
    end
  end
end
