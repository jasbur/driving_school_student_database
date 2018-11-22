class StudentsController < ApplicationController

	def index

	end

  def new
    @student = Student.new
  end

  def create
    student = Student.new

    #Manually parsing dates from the American format to ISO standard
    parsed_dob = Student.parse_american_date(params[:student][:dob])
    parsed_start_date = Student.parse_american_date(params[:student][:start_date])
    parsed_temps_issued = Student.parse_american_date(params[:student][:temps_issued])
    parsed_date_instructor_assigned = Student.parse_american_date(params[:student][:date_instructor_assigned])

    student.first_name = params[:student][:first_name]
    student.middle_initial = params[:student][:middle_initial]
    student.last_name = params[:student][:last_name]
    student.sex = params[:student][:sex]
    student.dob = parsed_dob
    student.street_address = params[:student][:street_address]
    student.city = params[:student][:city]
    student.state = params[:student][:state]
    student.zip_code = params[:student][:zip_code]
    student.phone_1 = params[:student][:phone_1]
    student.phone_2 = params[:student][:phone_2]
    student.start_date = parsed_start_date
    student.finish_date = params[:student][:finish_date]
    student.agreement_number = params[:student][:agreement_number]
    student.temps_number = params[:student][:temps_number]
    student.temps_issued = parsed_temps_issued
    student.class_number = params[:student][:class_number]
    student.electronically_filed = params[:student][:electronically_filed]
    student.program_cost = params[:student][:program_cost]
    student.behind_the_wheel_instructor = params[:student][:behind_the_wheel_instructor]
    student.date_instructor_assigned = parsed_date_instructor_assigned
    student.school_attend = params[:student][:school_attend]
    student.classroom_location = params[:student][:classroom_location]
    student.classroom_instructor = params[:student][:classroom_instructor]
    student.notes = params[:student][:notes]
    student.student_type = params[:student][:student_type]

    if student.save
      flash[:notice] = 'Student saved successfully!'
      redirect_to :action => 'new'
    else

      if student.first_name == "" or student.last_name == ""
        flash[:notice] = 'You must enter at least a First and Last name, student not saved.'
        redirect_to :action => 'new'
      else
        flash[:notice] = 'Something went wrong, please try again'
        redirect_to :action => 'new'
      end

    end
  end

  def show
    @student = Student.find_by_id(params[:id])
    @payments = Payment.find_all_by_student_id(@student.id)

    #Creating an array of payments for student's payments display or displaying the
    #total amount due (program cost minus discount amoujnt) if none found
    if @payments.size == 0
      @amount_due = @student.program_cost
    else
      @amount_due = Student.calculate_students_amount_due(@student, @payments)
    end

    @payments.sort! {|a,b| a.payment_date <=> b.payment_date}
  end

  def edit
    @student = Student.find_by_id(params[:id])
  end

  def update
    student = Student.find_by_id(params[:id])

    if student.update_attribute(:first_name, params[:student][:first_name]) and
      student.update_attribute(:middle_initial, params[:student][:middle_initial]) and
      student.update_attribute(:last_name, params[:student][:last_name]) and
      student.update_attribute(:sex, params[:student][:sex]) and
      student.update_attribute(:street_address, params[:student][:street_address]) and
      student.update_attribute(:city, params[:student][:city]) and
      student.update_attribute(:state, params[:student][:state]) and
      student.update_attribute(:zip_code, params[:student][:zip_code]) and
      student.update_attribute(:dob, params[:student][:dob][0..9]) and
      student.update_attribute(:phone_1, params[:student][:phone_1]) and
      student.update_attribute(:phone_2, params[:student][:phone_2]) and
      student.update_attribute(:start_date, params[:student][:start_date][0..9]) and
      student.update_attribute(:finish_date, params[:student][:finish_date][0..9]) and
      student.update_attribute(:agreement_number, params[:student][:agreement_number]) and
      student.update_attribute(:dl_number, params[:student][:dl_number]) and
      student.update_attribute(:temps_number, params[:student][:temps_number]) and
      student.update_attribute(:temps_issued, params[:student][:temps_issued][0..9]) and
      student.update_attribute(:class_number, params[:student][:class_number]) and
      student.update_attribute(:electronically_filed, params[:student][:electronically_filed]) and
      student.update_attribute(:program_cost, params[:student][:program_cost]) and
      student.update_attribute(:behind_the_wheel_instructor, params[:student][:behind_the_wheel_instructor]) and
      student.update_attribute(:date_instructor_assigned, params[:student][:date_instructor_assigned][0..9]) and
      student.update_attribute(:school_attend, params[:student][:school_attend]) and
      student.update_attribute(:classroom_location, params[:student][:classroom_location]) and
      student.update_attribute(:classroom_instructor, params[:student][:classroom_instructor]) and
      student.update_attribute(:notes, params[:student][:notes]) and
      student.update_attribute(:student_type, params[:student][:student_type])

      flash[:notice] = "Student record update sucessfully!"
      redirect_to :action => "show", :id => student.id
    else
      flash[:notice] = "Something went wrong, student record not updated"
      redirect_to :action => "edit", :id => student.id
    end
  end

  def destroy
    student = Student.find_by_id(params[:id])

    if student.destroy

      if params[:query]
        flash[:notice] = 'Student deleted successfully!'
        redirect_to :controller => "students", :action => 'list_students', :search_type => params[:search_type], :query => params[:query]
      else
        flash[:notice] = 'Student deleted successfully!'
        redirect_to :controller => "students", :action => 'index'
      end

    else
      flash[:notice] = 'Something went wrong, please try again'
      redirect_to :controller => "students", :action => 'index'
    end
  end

  def search

  end

  def list_students
    @query = params[:query]
    @search_type = params[:search_type]
    @students = Array.new

    #Searching for a student using the user supplied search type and query value
    if @query == "all"
      @students = Student.find(:all)
    else
      if @search_type == "last_name"
        @students = Student.find(:all, :conditions => [ "lower(last_name) LIKE ?", "%#{@query.downcase}%" ])
      elsif @search_type == "agreement_number"
        @students = Student.find(:all, :conditions => [ "agreement_number LIKE ?", "%#{@query}%" ])
      elsif @search_type == "classroom_instructor"
        @students = Student.find(:all, :conditions => [ "lower(classroom_instructor) LIKE ?", "%#{@query}%" ])
      elsif @search_type == "btw_instructor"
        @students = Student.find(:all, :conditions => [ "lower(behind_the_wheel_instructor) LIKE ?", "%#{@query}%" ])
      elsif @search_type == "phone_number"
        @students = Student.find(:all, :conditions => [ "phone_1 LIKE ? OR phone_2 LIKE ?", "%#{@query}%", "%#{@query}%" ])
      end
    end

    @students = @students.sort_by{ |x| [x.last_name, x.first_name] }
  end

  def print_office_record
    @student = Student.find_by_id(params[:student_id])
    @record_type = params[:record_type]

    render layout: false
  end

  def find_class_labels

  end

  def print_class_labels
    @students = Student.find_all_by_class_number(params[:query])

    @students.sort! {|a,b| a.last_name.downcase <=> b.last_name.downcase}

    render layout: false
  end

  def find_class_payments

  end

  def list_class_payments
    if params[:query] != ""
        @class_number = params[:query]
        @students = Student.find_all_by_class_number(params[:query])
        @students.sort! {|a,b| a.last_name.downcase <=> b.last_name.downcase}
    else
      flash[:notice] = 'Please enter a class number'
      redirect_to :action => 'find_class_payments'
    end
  end

  def print_class_payments
    @class_number = params[:class_number]
    @students = Student.find_all_by_class_number(@class_number)

    @students.sort! {|a,b| a.last_name.downcase <=> b.last_name.downcase}

    render layout: false
  end

  def find_class_printouts

  end

  def print_class_printouts
    @query = params[:query]
    @search_type = params[:search_type]

    if @query == ""
        @students = Array.new
    else
        @students = Student.find(:all, :conditions => [ "class_number = ?", @query ])
    end

    @students = @students.sort_by{ |x| [x.last_name, x.first_name] }

    render layout: false
  end

end
