class Payment < ActiveRecord::Base
  # attr_accessible :title, :body
  
  validates :payment_date, :presence => true
  
  #Converts and American style date string (DD/MM/YYYY) to ISO standard (YYYY/MM/DD)
  def self.parse_american_date(date_string)
    month = date_string.split(/[-\/]/)[0]
    day = date_string.split(/[-\/]/)[1]
    year = date_string.split(/[-\/]/)[2]
    
    parsed_date_string = "#{year}/#{month}/#{day}"
  end
  
end
