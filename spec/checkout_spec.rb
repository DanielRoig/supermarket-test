require 'rspec'
require './app/checkout'
require './app/pricing_rules'

RSpec.describe Checkout do
  subject { described_class.new(pricing_rules) }
  let(:pricing_rules) { PricingRules.new }

  let(:item1) do
    {
      product_code: 'GR1',
      name: 'Green tea',
      price: 311
    }
  end

  let(:item2) do
    {
      product_code: 'SR1',
      name: 'Strawberries',
      price: 500
    }
  end

  describe '#scan' do
    context 'when product does not exist in basket' do
      let(:item1_count) { 1 }
      it 'adds the item to basket' do
        subject.scan(item1)
        expect(subject.basket).to eql({ item1 => item1_count })
      end
    end

    context 'when product already exist in basket' do
      let(:item1_count) { 2 }
      it 'increse the count item' do
        subject.scan(item1)
        subject.scan(item1)
        expect(subject.basket).to eql({ item1 => item1_count })
      end
    end

    context 'when we two 2 diferent items in basket' do
      let(:item1_count) { 1 }
      let(:item2_count) { 1 }
      it 'has two items' do
        subject.scan(item1)
        subject.scan(item2)
        expect(subject.basket).to eql({ item1 => item1_count,
item2 => item2_count })
      end
    end
  end

  describe '#total' do
    context 'when products with no-discount are added' do
      it 'returns the total basket amount' do
        subject.scan(item1)
        subject.scan(item2)
        expect(subject.total).to eql('£8.11')
      end
    end

    context 'when products with no-discount and discount are added' do
      before do
        allow_any_instance_of(PricingRules).to \
          receive(:apply_discounts).and_return(nil)

        allow_any_instance_of(PricingRules).to \
          receive(:apply_discounts).with(item1,
                                         item1_count).and_return(total_item1_amount_price_discounted)
      end

      let(:total_item1_amount_price_discounted) { 200 }
      let(:item1_count) { 2 }

      it 'returns the total basket amount with discount added' do
        subject.scan(item1)
        subject.scan(item1)
        subject.scan(item2)

        expect(subject.total).to eql('£7.00')
      end
    end

    context 'when only products with discount are added' do
      before do
        allow_any_instance_of(PricingRules).to \
          receive(:apply_discounts).and_return(total_item1_amount_price_discounted)
      end

      let(:total_item1_amount_price_discounted) { 200 }

      it 'returns the total basket amount with discount added' do
        subject.scan(item1)
        subject.scan(item1)
        subject.scan(item2)

        expect(subject.total).to eql('£4.00')
      end
    end

    context 'when there are no products in basket' do
      it 'returns £0.00' do
        expect(subject.total).to eql('£0.00')
      end
    end
  end
end
