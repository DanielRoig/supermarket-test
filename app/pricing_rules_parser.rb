class PricingRulesParser
  class << self
    def total(item)
      @item = item

      calculate_price
    end

    private

    def calculate_price
      discounted_price = apply_dicount
      return regular_price unless discounted_price

      discounted_price
    end

    def apply_dicount
      return send(@item.pricing_rule['type']) unless @item.pricing_rule.nil?
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
      return unless @item.quantity >= @item.pricing_rule['min_quantity']

      @item.quantity * @item.pricing_rule['new_price']
    end

    def discount_percentage
      return unless @item.quantity >= @item.pricing_rule['min_quantity']

      x = @item.product.price * @item.pricing_rule['percentage']['numerator'] * @item.quantity

      x.divmod(@item.pricing_rule['percentage']['denominator']).sum

    end
  end
end
