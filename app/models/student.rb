class Student < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :payments

  validates :first_name, :last_name, :presence => true

  # Claculates the amount due for the given student given the initial program cost, payments provided, and discount
  def self.calculate_students_amount_due(student, payments)
    total_amount_paid = 0.0
    amount_due = 0.0

    payments.each{|payment|
        total_amount_paid = total_amount_paid + payment.amount
    }

    if student.program_cost.nil?
        amount_due = 0.0
    else
        amount_due = student.program_cost - total_amount_paid
    end

    return amount_due
  end

  # Converts and American style date string (DD/MM/YYYY) to ISO standard (YYYY/MM/DD)
  def self.parse_american_date(date_string)
    month = date_string.split(/[-\/]/)[0]
    day = date_string.split(/[-\/]/)[1]
    year = date_string.split(/[-\/]/)[2]

    parsed_date_string = "#{year}/#{month}/#{day}"
  end

  # Imports their existing database (in .csv format) to the current application database
  def self.import_old_database(csv_path)
    file = File.open(csv_path)

    file.each{|line|
        s = Student.new


        s.street_address = line.split(",")[7]
        s.city = line.split(",")[8]
        s.state = line.split(",")[9]
        s.phone_1 = line.split(",")[11]
        s.phone_2 = line.split(",")[12]
        s.first_name = line.split(",")[4]
        s.last_name =  line.split(",")[3]
        s.start_date = parse_american_date(line.split(",")[0])
        s.finish_date = parse_american_date(line.split(",")[1])
        s.agreement_number =  line.split(",")[2]
        s.middle_initial =  line.split(",")[5]
        s.zip_code =  line.split(",")[10]
        s.dl_number =  line.split(",")[41]
        s.temps_issued = parse_american_date(line.split(",")[43])
        s.class_number =  line.split(",")[40]
        s.electronically_filed =  ""
        s.program_cost =  line.split(",")[37]
        s.behind_the_wheel_instructor =  line.split(",")[28]
        s.date_instructor_assigned = parse_american_date(line.split(",")[32])
        s.school_attend =  line.split(",")[29]
        s.classroom_location =  line.split(",")[30]
        s.classroom_instructor =  line.split(",")[31]
        s.notes =  line.split(",")[42]
        s.student_type =  ""
        s.dob = parse_american_date(line.split(",")[6])
        s.sex =  "Unspecified"
        s.temps_number =  ""

        s.save


        # Parsing and insertion of the above student's payment information

        # Finds the student saved above so its ID can be used when saving the payments below
        saved_student = Student.find(:last)

        # Iterate through the first of four payments from the exisitng "old" database
        unless line.split(",")[15] == ""
            p1 = Payment.new
            p1.student_id = saved_student.id
            p1.amount = line.split(",")[15]

            # If no payment date was entered in the old database give it a default value of 1969/01/01
            if line.split(",")[24] == ""
                p1.payment_date = "1969/01/01"
            else
                p1.payment_date = parse_american_date(line.split(",")[24])
            end

            # If no receipt number was entered in the old database give it a default value of 00000
            if line.split(",")[20] == ""
                p1.receipt_number = "00000"
            else
                p1.receipt_number = line.split(",")[20]
            end

            p1.save
        end

        # Iterate through the second of four payments from the exisitng "old" database
        unless line.split(",")[16] == ""
            p2 = Payment.new
            p2.student_id = saved_student.id
            p2.amount = line.split(",")[16]

            # If no payment date was entered in the old database give it a default value of 1969/01/01
            if line.split(",")[25] == ""
                p2.payment_date = "1969/01/01"
            else
                p2.payment_date = parse_american_date(line.split(",")[25])
            end

            # If no receipt number was entered in the old database give it a default value of 00000
            if line.split(",")[21] == ""
                p2.receipt_number = "00000"
            else
                p2.receipt_number = line.split(",")[21]
            end

            p2.save
        end

        # Iterate through the third of four payments from the exisitng "old" database
        unless line.split(",")[17] == ""
            p3 = Payment.new
            p3.student_id = saved_student.id
            p3.amount = line.split(",")[17]

            # If no payment date was entered in the old database give it a default value of 1969/01/01
            if line.split(",")[26] == ""
                p3.payment_date = "1969/01/01"
            else
                p3.payment_date = parse_american_date(line.split(",")[26])
            end

            # If no receipt number was entered in the old database give it a default value of 00000
            if line.split(",")[22] == ""
                p3.receipt_number = "00000"
            else
                p3.receipt_number = line.split(",")[22]
            end

            p3.save
        end

        # Iterate through the fourth of four payments from the exisitng "old" database
        unless line.split(",")[18] == ""
            p4 = Payment.new
            p4.student_id = saved_student.id
            p4.amount = line.split(",")[18]

            # If no payment date was entered in the old database give it a default value of 1969/01/01
            if line.split(",")[27] == ""
                p4.payment_date = "1969/01/01"
            else
                p4.payment_date = parse_american_date(line.split(",")[27])
            end

            # If no receipt number was entered in the old database give it a default value of 00000
            if line.split(",")[23] == ""
                p4.receipt_number = "00000"
            else
                p4.receipt_number = line.split(",")[23]
            end

            p4.save
        end

    }
  end

end
