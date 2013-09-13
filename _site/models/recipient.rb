# Create a Recipients model.
class Recipient < Sequel::Model
  many_to_one :years
  one_to_many :payments

  def total_payments_by_recipient(recipient_id)
    beginning = Time.now
    # find payments by recipient
    recipient_payments = Payment.where(recipient_id: recipient_id)

    #add the payments together
    total_recipient_payments = 0
    recipient_payments.each do |payment|
      total_recipient_payments += payment
    end
  end

  #calculate total payment a recipient receives in a specified year
  def total_payment_amount_by_year(year)
    all_payments = Payment.where(year_id: Year.id_for(year)).
      where(recipient_id: self.id).all
    all_payments.inject(0.0) do |sum, payment|
      sum = sum + payment.amount_euro
    end
  end

end
