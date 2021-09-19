require 'rspec'
require './app/pricing_rules'

RSpec.describe PricingRules do
  subject { described_class.new }

  describe '#GR1 discount' do
    let(:item) do
      {
        product_code: 'GR1',
        name: 'Green tea',
        price: 311
      }
    end
    let(:item_price) { item[:price] }
    context 'when product count is even' do
      let(:item_count) { 4 }

      let(:total_item_amount_price_discounted) { item_price * item_count / 2 }
      it 'apply the discount' do
        expect(subject.apply_discounts(item,
                                       item_count)).to eql(total_item_amount_price_discounted)
      end
    end

    context 'when product count is odd' do
      let(:item_count) { 3 }
      let(:total_item_amount_price_discounted) do
        (item_price * (item_count + 1)) / 2
      end
      it 'apply the discount' do
        expect(subject.apply_discounts(item,
                                       item_count)).to eql(total_item_amount_price_discounted)
      end
    end
  end

  describe '#SR1 discount' do
    let(:item) do
      {
        product_code: 'SR1',
        name: 'Strawberries',
        price: 500
      }
    end

    let(:item_price) { item[:price] }

    let(:item_price_with_discount) { 450 }

    context 'when product count is < 3' do
      let(:item_count) { 2 }

      it 'not apply the discount' do
        expect(subject.apply_discounts(item,
                                       item_count)).to be_nil
      end
    end

    context 'when product count is >= 3' do
      let(:item_count) { 4 }
      let(:total_item_amount_price_discounted) do
        item_count * item_price_with_discount
      end

      it 'applys the discount' do
        expect(subject.apply_discounts(item,
                                       item_count)).to eql(total_item_amount_price_discounted)
      end
    end
  end

  describe '#CF1 discount' do
    let(:item) do
      {
        product_code: 'CF1',
        name: 'Coffee',
        price: 1123
      }
    end

    let(:item_price) { item[:price] }

    context 'when product count is < 3' do
      let(:item_count) { 2 }
      it 'not apply the discount' do
        expect(subject.apply_discounts(item,
                                       item_count)).to be_nil
      end
    end

    context 'when product count is >= 3' do
      let(:item_count) { 4 }
      let(:item_price_with_discount) { item_price.to_f * 2 / 3 }
      let(:total_item_amount_price_discounted) do
        (item_count.to_f * item_price_with_discount).floor
      end

      it 'applys the discount' do
        expect(subject.apply_discounts(item,
                                       item_count)).to eql(total_item_amount_price_discounted)
      end
    end
  end
end
