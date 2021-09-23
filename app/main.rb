require 'yaml'
require_relative 'pricing_rules'
require_relative 'checkout'
require_relative 'item'
require_relative 'product'

GR1 = Product.new('GR1', 'Green tea', 311)
SR1 = Product.new('SR1', 'Strawberries', 500)
CF1 = Product.new('CF1', 'Coffee', 1123)

pricing_rules = YAML.load(File.read("pricing_rules.yml"))

item1 = Item.new(GR1)
item2 = Item.new(SR1)
item3 = Item.new(CF1)

def create_new_basket(items, pricing_rules)
  co = Checkout.new(pricing_rules)
  items.each do |item|
    co.scan(item)
  end
  puts "Basket: #{items.map { |item| item.product.code }.join(',')}"
  puts "Total price expected: #{co.total}"
  puts "\n"
end

create_new_basket([item1, item2, item1, item1, item3], pricing_rules)

create_new_basket([item1, item1], pricing_rules)

create_new_basket([item2, item2, item1, item2], pricing_rules)

create_new_basket([item1, item3, item2, item3, item3], pricing_rules)
