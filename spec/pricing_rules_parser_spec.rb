require 'rspec'
require './app/item'
require './app/product'

RSpec.describe PricingRulesParser do
  subject { described_class }

  GR1 = Product.new('GR1', 'Green tea', 311)
  SR1 = Product.new('SR1', 'Strawberries', 500)
  CF1 = Product.new('CF1', 'Coffee', 1123)

  describe 'get_two_pay_one' do
    let(:quantity) { 2 }
    let(:item) { Item.new(GR1, pricing_rules, quantity) }
    let(:pricing_rules) do
      {
        'type' => 'get_two_pay_one'
      }
    end

    context 'we have even quantity' do
      let(:total_amount_with_discount) { (item.product.price * quantity) / 2 }
      it 'return total amount with discount' do
        expect(subject.total(item)).to eql(total_amount_with_discount)
      end
    end

    context 'we have odd quantity' do
      let(:quantity) { 3 }
      let(:total_amount_with_discount) do
        (item.product.price * (quantity + 1)) / 2
      end
      it 'return total amount with discount' do
        expect(subject.total(item)).to eql(total_amount_with_discount)
      end
    end
  end

  describe 'new_price' do
    let(:quantity) { 2 }
    let(:item) { Item.new(SR1, pricing_rules, quantity) }
    let(:new_price) { 450 }
    let(:min_qunatity) { 3 }
    let(:pricing_rules) do
      {
        'type' => 'new_price',
    'new_price' => new_price,
    'min_quantity' => min_qunatity
      }
    end

    context 'we do not have the min quantity' do
      let(:regular_price) { item.product.price * quantity }
      it 'return regular price' do
        expect(subject.total(item)).to eql(regular_price)
      end
    end

    context 'we have the min quantity' do
      let(:quantity) { 3 }
      let(:total_amount_with_discount) { new_price * quantity }
      it 'return total amount with discount' do
        expect(subject.total(item)).to eql(total_amount_with_discount)
      end
    end
  end

  describe 'discount_percentage' do
    let(:quantity) { 2 }
    let(:item) { Item.new(CF1, pricing_rules, quantity) }
    let(:min_qunatity) { 3 }
    let(:numerator) { 2 }
    let(:denominator) { 3 }
    let(:pricing_rules) do
      {
        'type' => 'discount_percentage',
    'percentage' => {
      'numerator' => numerator,
      'denominator' => denominator
    },
    'min_quantity' => min_qunatity
      }
    end

    context 'we do not have the min quantity' do
      let(:regular_price) { item.product.price * quantity }
      it 'return regular price' do
        expect(subject.total(item)).to eql(regular_price)
      end
    end

    context 'we have the min quantity' do
      let(:quantity) { 3 }
      let(:result) do
        (item.product.price * numerator * quantity).divmod(denominator)
      end
      let(:total_amount_with_discount) { result[0] * quantity }
      it 'return total amount with discount' do
        expect(subject.total(item)).to eql(result.sum)
      end
    end
  end

  describe 'item with no pricing rule' do
    let(:quantity) { 2 }
    let(:item) { Item.new(CF1, nil, quantity) }

    context 'we do not have pricing rule' do
      let(:regular_price) { item.product.price * quantity }
      it 'return regular price' do
        expect(subject.total(item)).to eql(regular_price)
      end
    end
  end
end
