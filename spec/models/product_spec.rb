require 'rails_helper'

RSpec.describe Product, type: :model do

  let (:category) {Category.new name:'Food'}

  subject {
    described_class.new(
      name: "Test",
      price: 100,
      quantity: 15,
      category: category
    )
  }

  describe 'Validations' do
    it 'should save a valid product' do
      subject.valid?
      expect(subject.errors.full_messages).to be_empty
    end

    it 'should not save without valid name' do
      subject.name = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Name can't be blank")
      end

    it 'should not save without valid price' do
      subject.price_cents = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not save without valid quantity' do
      subject.quantity = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save without valid category id' do
      subject.category = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Category can't be blank")
    end

  end
end
