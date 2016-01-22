class Transaction
  attr_reader :id, :customer, :product

  @@transactions = []
  @@id = 1

  def initialize(customer, product)
    @customer = customer
    @product = product
    assign_id
    add_to_transactions
    product.stock -= 1
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions[id - 1]
  end

  def self.find_by_customer(customer)
    search_transactions(customer)
  end

  def self.find_by_product(product)
    search_transactions(product)
  end

  def self.search_transactions(key)
    transactions = []
    @@transactions.each do |transaction|
      if transaction.customer.name == key
        transactions.push(transaction)
      elsif transaction.product.title == key
        transactions.push(transaction)
      end
    end
    transactions
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
