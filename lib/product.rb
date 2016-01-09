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

  private

  def add_to_products
    @@products.each do |product|
      raise DuplicateProductError, "#{self.title}' already exists." if product.title == self.title
    end
    @@products.push(self)
  end

end
