class PricingRulesParser
  class << self
    def total(item)
      @item = item
      @pricing_rule = item.pricing_rule

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
      unless @item.quantity.even?
        return ((@item.product.price * (@item.quantity + 1)) / 2)
      end

      ((@item.product.price * @item.quantity) / 2)
    end

    def new_price
      return unless @item.quantity >= @pricing_rule['min_quantity']

      @item.quantity * @pricing_rule['new_price']
    end

    def discount_percentage
      return unless @item.quantity >= @pricing_rule['min_quantity']

      x = @item.product.price * @pricing_rule['percentage']['numerator'] * @item.quantity

      q, r = x.divmod(@pricing_rule['percentage']['denominator'])

      q + r
    end
  end
end
