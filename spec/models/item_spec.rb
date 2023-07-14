require 'rails_helper'

RSpec.describe Item, type: :model do 
  describe 'relationships' do 
    it { should belong_to :merchant }
  end

  describe 'class methods' do 
    it "#find_by_name" do 
      merchant = Merchant.create!(name: "Music Go Round")
      jaguar = Item.create!( name: "Fender Jaguar",
        description: "offset, single coil pickups, guitar",
        unit_price: 400.99,
        merchant_id: merchant.id)

        expect(Item.find_by_name(name: "jaguar")[0]).to eq(jaguar)

    end
  end
end