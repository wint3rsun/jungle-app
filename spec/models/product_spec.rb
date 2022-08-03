require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save successfully' do
      @category = Category.create(name:'Games')
      product = Product.new(
        name: 'Pokemon Go',
        price_cents: 100.00,
        quantity: 50,
        category_id: @category.id
      )
      expect(product).to be_valid
    end
  end
end
