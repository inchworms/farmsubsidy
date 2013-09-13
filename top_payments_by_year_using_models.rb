require 'csv'
require 'rubygems'
require 'sequel'
require 'json'

# connect to an postgres database
DB = Sequel.postgres("farmsubsidy_performance")

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + "/models/*.rb").each{|f| require f}

payments_sorted = Payment.sorted(2009,20)

top_payments = []

# find recipient name, create an index, shove it into top_payments hash
payments_sorted.each_with_index do |payment, index|
  recipient_name = Recipient.where(id: payment[:recipient_id]).first[:name].gsub("\"", "")
  top_payments << {rank: index+1, name: recipient_name, amount: payment[:amount_euro]}
end

CSV.open("top_payments.csv", "w", :force_quotes => true) do |csv|
  i = 0
  csv << ["rank","name","amount"]
  while i < top_payments.length
    csv << [top_payments[i][:rank],top_payments[i][:name],top_payments[i][:amount].to_i]
    i += 1
  end
end


@top_payments_json = []
@top_payments_json = top_payments.to_json

puts "our results are: "
puts "from csv:"
system("cat top_payments.csv")
puts "\nFrom Json object:"
puts @top_payments_json

# puts "our results are: "
# system("cat top_payments.csv")


recipient_id = 2337
recipient = Recipient[:id=> recipient_id]

puts "total amount of payment from one recipient with id #{recipient_id}:"
puts recipient.total_payment_amount
