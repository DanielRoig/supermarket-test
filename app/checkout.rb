class Checkout
  attr_reader :basket

  def initialize(pricing_rules)
    @basket = []
    @pricing_rules = pricing_rules
  end

  def scan(item)
    add_item_to_basket(item)
  end

  def total
    total_basket_amount = sum_basket_amount

    to_currency(total_basket_amount)
  end

  private

  def sum_basket_amount
    total_basket_amount = 0
    @basket.each do |item|
      total_basket_amount += sum_item_amount(item)
    end
    total_basket_amount
  end

  def sum_item_amount(item)
    total_item_amount_price_discounted = apply_discounts(item)
    unless total_item_amount_price_discounted.nil?
      return total_item_amount_price_discounted
    end

    item.product.price * item.quantity
  end

  def apply_discounts(item)
    @pricing_rules.apply_discounts(item)
  end

  def add_item_to_basket(item)
    item_in_basket = item_in_basket?(item.product.code)

    return @basket << item unless item_in_basket

    item_in_basket.increse_quantity
  end

  def item_in_basket?(product_code)
    @basket.find { |item| item.product.code == product_code }
  end

  def to_currency(amount)
    "£#{format('%.02f', (amount / 100.0))}"
  end
end
