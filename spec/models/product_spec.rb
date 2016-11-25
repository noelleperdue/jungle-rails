require 'rails_helper'

RSpec.describe Product, type: :model do

  context 'Validations' do

    it "is valid with all attributes" do
      @category = Category.create(name: 'VHS Tapes')
      @product = Product.create(name: 'Pulp Fiction', price_cents: 299 , quantity: 5, category_id: @category.id)
      @product.validate!
      @product.errors.full_messages
    end

    it "is not valid without name" do
      @category = Category.create(name: 'VHS Tapes')
      @product = Product.create(name: nil, price_cents: 299, quantity: 3, category_id: @category.id)
      expect(@product).to_not be_valid
      @product.errors.full_messages
    end

    it "is not valid without price" do
      @category = Category.create(name: 'VHS Tapes')
      @product = Product.create(name: 'Titanic', price_cents: nil, quantity: 5, category_id: @category.id)
      expect(@product).to_not be_valid
      @product.errors.full_messages
    end

    it "is not valid without quantity" do
      @category = Category.create(name: 'VHS Tapes')
      @product = Product.create(name: 'Home Alone', price_cents: 299, quantity: nil, category_id: @category.id)
      expect(@product).to_not be_valid
      @product.errors.full_messages
    end

    it "is not valid without category" do
      @category = Category.create(name: 'VHS Tapes')
      @product = Product.create(name: 'Jurassic Park', price_cents: 299, quantity: 2, category_id: nil)
      expect(@product).to_not be_valid
      @product.errors.full_messages
    end
  end
end