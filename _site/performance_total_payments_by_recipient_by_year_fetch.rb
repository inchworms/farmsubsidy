require 'rubygems'
require 'sequel'
require 'logger'


# connect to an in-memory database
DB = Sequel.postgres("farmsubsidy_performance", :loggers => [Logger.new($stdout)])

# connect to the models
project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + "/models/*.rb").each{|f| require f}

# connect to payments total table and add data to the database
total_payment = DB[:payment_year_totals]

# look through all recipients and all years and insert the total amount
Recipient.all.each do |recipient|
  Year.all.each do |year|
    total = recipient.total_payment_amount_by_year(year.year)
    #make sure the total isn't 0
    if total != 0.0
      total_payment.insert(
        recipient_id: recipient.id,
        year_id: year.id,
        amount_euro: total
        )
    end
  end
end
