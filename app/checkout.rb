require_relative 'item'

class Checkout
  attr_reader :basket

  def initialize(pricing_rules)
    @basket = []
    @pricing_rules = pricing_rules
  end

  def scan(product)
    add_item_to_basket(product)
  end

  def total
    total_basket_amount = @basket.sum { |item| item.total }

    to_currency(total_basket_amount)
  end

  private

  def add_item_to_basket(product)
    basket_item = find_basket_item(product.code)

    return initialize_item(product) unless basket_item

    basket_item.increse_quantity
  end

  def initialize_item(product)
    @basket << Item.new(product, pricing_rule(product.code))
  end

  def find_basket_item(product_code)
    @basket.find { |item| item.product.code == product_code }
  end

  def pricing_rule(product_code)
    @pricing_rules[product_code]
  end

  def to_currency(amount)
    "£#{format('%.02f', (amount / 100.0))}"
  end
end
