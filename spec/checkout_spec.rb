require 'rspec'
require './app/checkout'
require './app/product'
require './app/Item'

RSpec.describe Checkout do
  subject { described_class.new(pricing_rules) }

  let(:pricing_rules) { { 'GR1' => { 'type' => 'get_two_pay_one' } } }

  GR1 = Product.new('GR1', 'Green tea', 311)
  CF1 = Product.new('CF1', 'Coffee', 1123)

  describe '#scan' do
    context 'when product does not exist in basket' do
      let(:scan_item) { subject.scan(GR1) }

      it 'adds the item to basket' do
        expect { scan_item }.to change { subject.basket.length }.by(1)
      end
    end

    context 'when product already exist in basket' do
      it 'does not add same item' do
        subject.scan(GR1)
        subject.scan(GR1)
        expect(subject.basket.length).to eql(1)
      end
    end

    context 'when we add two 2 diferent items in basket' do
      it 'has two items' do
        subject.scan(GR1)
        subject.scan(CF1)
        expect(subject.basket.length).to eql(2)
      end
    end
  end

  describe '#total' do
    before do
      allow_any_instance_of(Item).to \
        receive(:total).and_return(200)
    end
    context 'when there are products in basket' do
      it 'returns the sum of total items' do
        subject.scan(GR1)
        subject.scan(CF1)
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
