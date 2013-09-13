# Create a Payments model.
class Payment < Sequel::Model
  many_to_one :recipients


  def self.number
    self.count
  end

  # = are default params
  def self.sorted(year=2007,limit=20)
    self.where(year_id: Year.id_for(year)).
          reverse_order(:amount_euro).
          limit(limit).
          all
  end
end

