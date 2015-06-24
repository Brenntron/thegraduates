class AddGradDateAndCohortNum < ActiveRecord::Migration
  def change
    add_column :users, :cohort, :integer
    add_column :users, :graudation_date, :date
  end
end
