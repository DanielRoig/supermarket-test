class PricingRules
  def apply_discounts(item)
    item_price = item.product.price
    item_product_code = item.product.code

    case item.product.code
    when 'GR1' then gr1_discount(item_price, item.quantity)
    when 'SR1' then sr1_discount(item.quantity)
    when 'CF1' then cf1_discount(item_price, item.quantity)
    end
  end

  private

  def gr1_discount(item_price, item_count)
    return ((item_price * (item_count + 1)) / 2) unless item_count.even?

    ((item_price * item_count) / 2)
  end

  def sr1_discount(item_count)
    return unless item_count >= 3

    item_count * 450
  end

  def cf1_discount(item_price, item_count)
    return unless item_count >= 3

    (item_price.to_f * 2 / 3 * item_count.to_f).floor
  end
end
