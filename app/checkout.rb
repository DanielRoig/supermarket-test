class Checkout
  attr_reader :basket

  def initialize(pricing_rules)
    @basket = {}
    @pricing_rules = pricing_rules
  end

  def scan(item)
    add_product_basket(item)
  end

  def total
    total_basket_amount = sum_basket_amount

    to_currency(total_basket_amount)
  end

  private

  def sum_basket_amount
    total_basket_amount = 0
    @basket.each do |item, item_count|
      total_basket_amount += sum_item_amount(item, item_count)
    end
    total_basket_amount
  end

  def sum_item_amount(item, item_count)
    total_item_amount_price_discounted = apply_discounts(item, item_count)
    unless total_item_amount_price_discounted.nil?
      return total_item_amount_price_discounted
    end

    item[:price] * item_count
  end

  def apply_discounts(item, count)
    @pricing_rules.apply_discounts(item, count)
  end

  def add_product_basket(item)
    @basket[item] ||= 0
    @basket[item] += 1
  end

  def to_currency(amount)
    "£#{format('%.02f', (amount / 100.0))}"
  end
end
