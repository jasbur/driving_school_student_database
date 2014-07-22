class AddNewFieldsToStudentsFromDiscoveryMeeting < ActiveRecord::Migration
  def change
  	add_column :students, :start_date, :datetime
  	add_column :students, :finish_date, :datetime
  	add_column :students, :agreement_number, :string
  	add_column :students, :middle_initial, :string
  	add_column :students, :zip_code, :string
  	add_column :students, :dl_number, :string
  	add_column :students, :temps_issued, :datetime
  	add_column :students, :class_number, :string
  	add_column :students, :electronically_filed, :boolean
  	add_column :students, :date_issued, :datetime
  	add_column :students, :program_cost, :float
  	add_column :students, :discount_type, :string
  	add_column :students, :discount_amount, :float
  	add_column :students, :payment_plan_number, :string
  	add_column :students, :behind_the_wheel_instructor, :string
  	add_column :students, :date_instructor_assigned, :datetime
  	add_column :students, :school_attend, :string
  	add_column :students, :classroom_location, :string
  	add_column :students, :classroom_instructor, :string
  	add_column :students, :notes, :text
  end
end
