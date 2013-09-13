project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + "/models/*.rb").each{|f| require f}

new_payment = Payment.new
new_payment.values[:amount_euro] = 1
new_payment.save
p new_payment

# to see it: 
# in psql:
# SELECT id FROM payments WHERE amount_euro = 1;