require 'yaml'
require_relative 'pricing_rules'
require_relative 'checkout'
require_relative 'item'
require_relative 'product'

GR1 = Product.new('GR1', 'Green tea', 311)
SR1 = Product.new('SR1', 'Strawberries', 500)
CF1 = Product.new('CF1', 'Coffee', 1123)

pricing_rules = YAML.load(File.read("pricing_rules.yml"))

def create_new_basket(items, pricing_rules)
  co = Checkout.new(pricing_rules)
  items.each do |item|
    co.scan(item)
  end
  puts "Basket: #{items.map { |item| item.code }.join(',')}"
  puts "Total price expected: #{co.total}"
  puts "\n"
end

create_new_basket([GR1, SR1, GR1, GR1, CF1], pricing_rules)

create_new_basket([GR1, GR1], pricing_rules)

create_new_basket([SR1, SR1, GR1, SR1], pricing_rules)

create_new_basket([GR1, CF1, SR1, CF1, CF1], pricing_rules)
