class ChangeFalvorsToFlavors < ActiveRecord::Migration[5.2]
  def change
    rename_table :falvors, :flavors
  end
end
