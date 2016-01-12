class Transaction
  attr_reader :id, :customer, :product

  @@transactions = []
  @@id = 1

  def initialize(customer, product, type)
    @customer = customer
    @product = product
    type_of_transaction(type)
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

  def type_of_transaction(type)
    if type == "purchase"
      @product.decrement_stock_by_one
    elsif type == "return"
      @product.increment_stock_by_one
    else
      raise TransactionTypeError, "'#{type}' is not a valid transaction type"
    end
  end

end
