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
    if product.stock == 0
      fail OutOfStockError, "'#{product.title}' is out of stock."
    end
    @products_purchased.push(product)
    Transaction.new(self, product)
  end

  def return(product)
    unless @products_purchased.include?(product)
      fail NotProductOwnerError, "#{@name} does not own #{product.title}"
    end
    product.stock += 1
    # I needed to just delete the first item in the array that matched a product
    # title, and I got the solution from
    # http://stackoverflow.com/questions/17903351/delete-one-array-element-by-value-in-ruby
    @products_purchased.delete_at(@products_purchased.find_index(product))
    Transaction.new(self, product)
  end

  private

  def add_to_customers
    @@customers.each do |customer|
      if customer.name == name
        fail DuplicateCustomerError, "'#{customer.name}' already exists"
      end
    end
    @@customers.push(self)
  end
end
