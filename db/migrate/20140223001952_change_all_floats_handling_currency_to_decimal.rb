class ChangeAllFloatsHandlingCurrencyToDecimal < ActiveRecord::Migration
  def up
  	change_column :students, :program_cost, :decimal
  	change_column :students, :discount_amount, :decimal
  end

  def down
  	change_column :students, :program_cost, :float
  	change_column :students, :discount_amount, :float
  end
end
