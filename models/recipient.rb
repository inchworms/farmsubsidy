# Create a Recipients model.
class Recipient < Sequel::Model
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

  # def total_payment_amount
  #   Payment.where(recipient_id: self.id).sum[:amount_euro]
  # end

  def total_payment_amount
    self.payments.inject(0.0) do |sum,payment|
      sum = sum + payment.amount_euro
    end
  end

  # is the same as:
  # def total_payment_amount
  #   sum = 0.0
  #   self.payments.each do |payment|
  #     sum = sum + payment.amount_euro
  #   end
  #   sum
  # end

end
