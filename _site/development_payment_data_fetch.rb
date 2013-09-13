require 'csv'
require 'rubygems'
require 'sequel'


# connect to an in-memory database
DB = Sequel.postgres("farmsubsidy_development")

# create a dataset from the payments table
payment = DB[:payments]

#create a dataset from the years table
years = DB[:years]

#create a dataset from the recipients table
recipients = DB[:recipients]

i = 0
payment_txt = CSV.open("data/cz_payment.txt", "r:UTF-8", :headers => true, :col_sep => ";") do |csv|
  csv.each do |row|
      print "." if i%100 == 0
      # find the year_id by searching years dataset
      year_id = years.where(:year=>row['year']).first[:id]

      # find the recipient_id by searching recipient dataset
      recipient_id = recipients.where(:global_recipient_id=>row['globalRecipientId']).first[:id]

      # insert data into payments table
      payment.insert(
        amount_euro: row['amountEuro'],
        year_id: year_id,
        recipient_id: recipient_id
      )
    i += 1
  end
end