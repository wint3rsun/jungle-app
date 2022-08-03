require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.create(name:'Games')
    end

    it 'should save successfully' do
      product = Product.new(
        name: 'Pokemon Go',
        price_cents: 100.00,
        quantity: 50,
        category_id: @category.id
      )
      expect(product).to be_valid
    end

    it 'should validate that a name is present' do
      product = Product.new(
        name: nil,
        price_cents: 100.00,
        quantity: 50,
        category_id: @category.id
      )
      expect(product).to be_invalid
    end

    it 'should validate that a price is present' do
      product = Product.new(
        name: 'Pokemon Go',
        price_cents: nil,
        quantity: 50,
        category_id: @category.id
      )
      expect(product).to be_invalid
    end

    it 'should validate that a quantity is present' do
      product = Product.new(
        name: 'Pokemon Go',
        price_cents: 100.00,
        quantity: nil,
        category_id: @category.id
      )
      expect(product).to be_invalid
    end

    it 'should validate that a category is present' do
      product = Product.new(
        name: 'Pokemon Go',
        price_cents: 100.00,
        quantity: 50,
        category_id: nil
      )
      expect(product).to be_invalid
    end

  end
end
