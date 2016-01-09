class Product
  @@products = []

  def initialize(options = {})
    @@products.push(self)
  end

  def self.all
    @@products
  end

end
