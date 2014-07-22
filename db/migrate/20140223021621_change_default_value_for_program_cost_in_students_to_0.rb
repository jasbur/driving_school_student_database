class ChangeDefaultValueForProgramCostInStudentsTo0 < ActiveRecord::Migration
  def up
  	change_column :students, :program_cost, :decimal, :default => 0
  end

  def down
  	change_column :students, :program_cost, :decimal, :default => nil
  end
end
