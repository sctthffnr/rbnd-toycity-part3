class Customer
  attr_reader :name

  @@customers = []

  def initialize(options = {})
    @name = options[:name]
    @products_purchased = []
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
    @products_purchased.push(product)
    Transaction.new(self, product)
  end

  def return(product)
    raise NotProductOwnerError, "#{@name} does not own #{product.title}" unless @products_purchased.include?(product)
    transaction = Transaction.new(self, product)
    product.stock += 1
    # I needed to just delete the first item in the array that matched a product title, and I got the solution
    # from http://stackoverflow.com/questions/17903351/delete-one-array-element-by-value-in-ruby
    @products_purchased.delete_at(@products_purchased.find_index(product))
  end

  private

  def add_to_customers
    @@customers.each do |customer|
      raise DuplicateCustomerError, "'#{customer.name}' already exists" if customer.name == self.name
    end
    @@customers.push(self)
  end
end
