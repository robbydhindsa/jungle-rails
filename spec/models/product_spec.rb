require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "saves successfully when all four fields are set" do
      @category = Category.new(:name => "Test Category")
      @product = Product.new(
        :name => "New Plant",
        :price => 100,
        :quantity => 23,
        :category => @category
      )
      expect(@product).to be_valid
    end

    it "validates the presence of name" do
      @category = Category.new(:name => "Test Category")
      @product = Product.new(
        :name => nil,
        :price => 100,
        :quantity => 23,
        :category => @category
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "validates the presence of price" do
      @category = Category.new(:name => "Test Category")
      @product = Product.new(
        :name => "New Plant",
        :price => nil,
        :price_cents => nil,
        :quantity => 23,
        :category => @category
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include(
        "Price cents is not a number",
        "Price is not a number",
        "Price can't be blank"
      )
    end

    it "validates the presence of quantity" do
      @category = Category.new(:name => "Test Category")
      @product = Product.new(
        :name => "New Plant",
        :price => 100,
        :quantity => nil,
        :category => @category
      )
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "validates the presence of category" do
      @category = Category.new(:name => "Test Category")
      @product = Product.new(
        :name => "New Plant",
        :price => 100,
        :quantity => 23,
        :category => nil
      )
      @product.save
      p @product.errors.full_messages
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include(
        "Category must exist",
        "Category can't be blank"
      )
    end

  end
end
