class RenameTempIssuedToTempsIssued < ActiveRecord::Migration
  def up
    rename_column :students, :temp_number, :temps_number
  end

  def down
    rename_column :students, :temps_number, :temp_number
  end
end
