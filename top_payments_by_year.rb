require 'csv'
require 'rubygems'
require 'sequel'
require 'logger'

# top_payments will be an aray of hashes with the final results
# eg [{rank: 1, name: "horst", amount: 234556}, {...}]
top_payments = []

# connect to an in-memory database
DB = Sequel.postgres("farmsubsidy_performance", :loggers => [Logger.new($stdout)])

#select a year between 2004 and 2011
p "Select a year between 2004 and 2011:"
year_selection = gets

# find the year_id from the years table
year_id = DB[:years].where(year: year_selection.to_i).first[:id]

# find payments by year, order them by amount, and return the first 20
payments_sorted = DB[:payments].where(year_id: year_id).
																reverse_order(:amount_euro).
																limit(20)

# find recipient name, create an index, shove it into top_payments hash
payments_sorted.each_with_index do |payment, index|
	recipient_name = DB[:recipients].where(id: payment[:recipient_id]).first[:name].gsub("\"", "")
	top_payments << {rank: index+1, name: recipient_name, amount: payment[:amount_euro]}
end

p top_payments




