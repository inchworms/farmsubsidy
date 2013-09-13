require 'csv'
require 'rubygems'
require 'sequel'


# connect to an in-memory database
DB = Sequel.postgres("farmsubsidy_development")


# create a dataset from the recipient data
recipient = DB[:recipients]
i = 0
recipient_txt = CSV.open("data/cz_recipient.txt", "r:UTF-8", :headers => true, :col_sep => ";") do |csv|
  csv.each do |row|
      print "." if i%100 == 0
      recipient.insert(
        global_recipient_id: row['globalRecipientId'],
        zipcode: row['zipcode'],
        name: row['name']
      )
    i += 1
  end
end


