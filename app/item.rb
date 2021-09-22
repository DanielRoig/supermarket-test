class Item
  attr_reader :product, :quantity

  def initialize(product)
    @product = product
    @quantity = 1
  end

  def increse_quantity
    @quantity += 1
  end
end
