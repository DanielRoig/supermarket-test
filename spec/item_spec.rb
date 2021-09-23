require 'rspec'
require './app/item'
require './app/product'
require './app/pricing_rules_parser'

RSpec.describe Item do
  subject { described_class }

  let(:code) { 'GR1' }
  let(:name) { 'Green tea' }
  let(:price) { 311 }

  let(:new_product) { Product.new(code, name, price) }
  let(:new_item) { subject.new(new_product) }

  describe '#Create item' do
    context 'when item is created' do
      it 'is a instance of Item' do
        expect(new_item).to be_an_instance_of(subject)
      end

      it 'fills the attributes' do
        expect(new_item.product).to eql(new_product)
        expect(new_item.quantity).to eql(1)
        expect(new_item.pricing_rule).to eql(nil)
      end
    end
  end

  describe '#Increse_quantity' do
    context 'when method is called' do
      it 'increases the item quantity' do
        new_item.increse_quantity
        expect { new_item.increse_quantity }.to change {
                                                  new_item.quantity
                                                } .by(1)
      end
    end
  end
end
