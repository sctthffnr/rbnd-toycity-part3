class Customer
  attr_reader :name

  @@customers = []

  def initialize(options = {})
    @name = options[:name]
    add_to_customers
  end

  def self.all
    @@customers
  end

  def self.find_by_name(name)
    @@customers.each do |customer|
      return customer if customer.name == name
    end
  end

  def purchase(product)
    raise OutOfStockError, "'#{product.title}' is out of stock." if product.stock == 0
    transaction = Transaction.new(self, product)
  end

  private

  def add_to_customers
    @@customers.each do |customer|
      raise DuplicateCustomerError, "'#{customer.name}' already exists" if customer.name == self.name
    end
    @@customers.push(self)
  end
end
