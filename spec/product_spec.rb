require 'rspec'
require './app/product'

RSpec.describe Product do
  subject { described_class }

  let(:code) { 'GR1' }
  let(:name) { 'Green tea' }
  let(:price) { 311 }

  let(:new_product) { subject.new(code, name, price) }

  describe '#Create product' do
    context 'when product is created' do
      it 'is a instance of Product' do
        expect(new_product).to be_an_instance_of(subject)
      end

      it 'fills the attributes' do
        expect(new_product.code).to eql(code)
        expect(new_product.name).to eql(name)
        expect(new_product.price).to eql(price)
      end
    end
  end
end
