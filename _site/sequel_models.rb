require 'rubygems'
require 'sequel'

# connect to an in-memory database
DB = Sequel.postgres("farmsubsidy_performance")

# Create a Year model.
class Year < Sequel::Model; 
	one_to_many :recipients
end

# Create a Recipients model.
class Recipient < Sequel::Model; 
	many_to_one :years
	one_to_many :payments
end

# Create a Payments model.
class Payment < Sequel::Model; 
	many_to_one :recipients
end

