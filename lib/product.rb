class Product
  attr_reader :title

  @@products = []

  def initialize(options = {})
    @title = options[:title]
    add_to_products
  end

  def self.all
    @@products
  end

  private

  def add_to_products
    @@products.each do |product|
      raise DuplicateProductError, "#{self.title}' already exists." if product.title == self.title
    end
    @@products.push(self)
  end

end
