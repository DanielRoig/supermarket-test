require_relative 'pricing_rules_parser'

class Item
  attr_reader :product, :quantity, :pricing_rule

  def initialize(product, pricing_rule = nil, quantity = 1)
    @product = product
    @pricing_rule = pricing_rule
    @quantity = quantity
  end

  def increse_quantity
    @quantity += 1
  end

  def total
    pricing_rules_parser
  end

  private

  def pricing_rules_parser
    PricingRulesParser.total(self)
  end
end
