require_relative 'pricing_rules'
require_relative 'checkout'

item1 = {
  product_code: 'GR1',
  name: 'Green tea',
  price: 311
}

item2 = {
  product_code: 'SR1',
  name: 'Strawberries',
  price: 500
}

item3 = {
  product_code: 'CF1',
  name: 'Coffee',
  price: 1123
}

pricing_rules = PricingRules.new

def create_new_basket(items, pricing_rules)
  co = Checkout.new(pricing_rules)
  items.each do |item|
    co.scan(item)
  end
  puts "Basket: #{items.map { |item| item[:product_code] }.join(',')}"
  puts "Total price expected: #{co.total}"
  puts "\n"
end

create_new_basket([item1, item2, item1, item1, item3], pricing_rules)

create_new_basket([item1, item1], pricing_rules)

create_new_basket([item2, item2, item1, item2], pricing_rules)

create_new_basket([item1, item3, item2, item3, item3], pricing_rules)
