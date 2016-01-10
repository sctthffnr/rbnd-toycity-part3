class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options = {})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
    @@products.each do |product|
      return product if product.title == title
    end
  end

  def in_stock?
    self.stock > 0 ? true : false
  end

  def self.in_stock
    products_in_stock = []
    @@products.each do |product|
      products_in_stock.push(product) if product.in_stock?
    end
    return products_in_stock
  end

  def decrement_stock_by_one
    @stock -= 1
  end

  private

  def add_to_products
    @@products.each do |product|
      raise DuplicateProductError, "#{self.title}' already exists." if product.title == self.title
    end
    @@products.push(self)
  end

end
