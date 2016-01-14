class Transaction
  attr_reader :id, :customer, :product

  @@transactions = []
  @@id = 1

  def initialize(customer, product)
    @customer = customer
    @product = product
    assign_id
    add_to_transactions
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions[id - 1]
  end

  def self.find_by_customer(customer)
    transactions = []
    @@transactions.each do |transaction|
      transactions.push(transaction) if transaction.customer == customer
    end
    return transactions
  end

  def self.find_by_product(product)
    transactions = []
    @@transactions.each do |transaction|
      transactions.push(transaction) if transaction.product == product
    end
    return transactions
  end

  private

  def add_to_transactions
    @@transactions.push(self)
  end

  def assign_id
    @id = @@id
    @@id += 1
  end

  def self.search_transactions(key, value)
    transactions = []
    @@transactions.each do |transaction|
      transactions.push(transaction) if transaction.key == value
    end
    return transactions
  end

end
