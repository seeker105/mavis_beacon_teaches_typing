class AddNameToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :name, :string
  end
end
