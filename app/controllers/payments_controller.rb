class PaymentsController < ApplicationController

	def index
		
	end

	def new
		@payment = Payment.new
		@student = Student.find_by_id(params[:student_id])
	end

	def create
		payment = Payment.new
		
		#Manually parsing date from the American format to ISO standard
		parsed_payment_date = Payment.parse_american_date(params[:payment][:payment_date])
		
		payment.student_id = params[:payment][:student_id]
		payment.amount = params[:payment][:amount]
		payment.payment_date = parsed_payment_date
		payment.receipt_number = params[:payment][:receipt_number]

		if payment.save
		  flash[:notice] = 'Payment saved successfully!'
		  redirect_to :controller => "students", :action => 'show', :id => params[:payment][:student_id]
		else
		  
		  if payment.payment_date.nil?
		    flash[:notice] = 'Please enter a valid date, payment not saved'
        redirect_to :action => 'new', :student_id => params[:payment][:student_id]
		  else
		    flash[:notice] = 'Something went wrong, payment not saved. Please try again'
        redirect_to :action => 'new', :student_id => params[:payment][:student_id]
		  end
		  
		end
	end

	def show
		@payment = Payment.find_by_id(params[:id])
	end
	
	def edit
	    @payment = Payment.find_by_id(params[:id])
	end
	
	def update
        payment = Payment.find_by_id(params[:id])

        if payment.update_attribute(:amount, params[:payment][:amount]) and
          payment.update_attribute(:payment_date, params[:payment][:payment_date]) and 
          payment.update_attribute(:receipt_number, params[:payment][:receipt_number])
          
          flash[:notice] = "Payment updated sucessfully!"
          redirect_to :controller => "students",:action => "show", :id => payment.student_id
        else
          flash[:notice] = "Something went wrong, record not updated."
          redirect_to :controller => "payments",:action => "edit", :id => payment.id
        end
    end

	def destroy
		payment = Payment.find_by_id(params[:id])
		student_id = payment.student_id

		if payment.destroy
			flash[:notice] = 'Payment deleted successfully!'
		 	redirect_to :controller => "students", :action => 'show', :id => student_id
		else
			flash[:notice] = 'Something went wrong, please try again'
		 	redirect_to :controller => "students", :action => 'show', :id => student_id
		end
	end

end
