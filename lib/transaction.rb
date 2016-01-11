class Transaction
  attr_reader :id, :customer, :product

  @@transactions = []
  @@id = 1

  def initialize(customer, product)
    @customer = customer
    @product = product
    product.decrement_stock_by_one
    assign_id
    add_to_transactions
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions[id - 1]
  end

  private

  def add_to_transactions
    @@transactions.push(self)
  end

  def assign_id
    @id = @@id
    @@id += 1
  end

end
