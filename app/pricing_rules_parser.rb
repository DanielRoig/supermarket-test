class PricingRulesParser
  class << self
    def total(item)
      @item = item
      @item.pricing_rule = item.pricing_rule

      calculate_price
    end

    private

    def calculate_price
      send(@pricing_rule['type']) || regular_price
    end

    def regular_price
      @item.product.price * @item.quantity
    end

    def get_two_pay_one
      return ((@item.product.price * (item.quantity + 1)) / 2) unless item.quantity.even?

      ((@item.product.price * item.quantity) / 2)
    end

    def new_price
      return unless item.quantity >= @pricing_rule['min_quantity']

      item.quantity * @pricing_rule['new_price']
    end

    def discount_percentage
      return unless item.quantity >= @pricing_rule['min_quantity']

      x = @item.product.price * 2 * @item.quantity

      q, r = x.divmod(3)

      q+r
    end
  end
end
