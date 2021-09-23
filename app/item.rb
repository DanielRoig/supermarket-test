class Item
  attr_reader :product, :quantity, :pricing_rule

  def initialize(product, pricing_rule)
    @product = product
    @pricing_rule = pricing_rule
    @quantity = 1
  end

  def increse_quantity
    @quantity += 1
  end
end
