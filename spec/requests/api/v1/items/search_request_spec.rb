require 'rails_helper'

RSpec.describe "/items/find_all" do 
  describe "find all items by name" do 
    it "can find all items by name fragment" do 
      merchant = Merchant.create!(name: "Target")

      jazzmaster = Item.create!(name: "Fender Jazzmaster",
      description: "offset, flat single coil pickups, guitar",
      unit_price: 400.99,
      merchant_id: merchant.id) 

      jaguar = Item.create!( name: "Fender Jaguar",
        description: "offset, single coil pickups, guitar",
        unit_price: 400.99,
        merchant_id: merchant.id) 
      
      stratocaster = Item.create!( name: "Fender Stratocaster",
        description: "single coil pickups, guitar",
        unit_price: 400.99,
        merchant_id: merchant.id) 

      query_params = { name: "fender" }

      get "/api/v1/items/find_all", params: query_params

      expect(response).to be_successful
      expect(response.status).to eq(200)

      items = JSON.parse(response.body, symbolize_names: true)
      expect(items).to have_key(:data)
      expect(items[:data].count).to eq(3)
      expect(items[:data]).to be_an(Array)

      item = items[:data][0]

      expect(item).to have_key(:id)
      expect(item).to have_key(:type)
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to eq("Fender Jazzmaster")
    end
  end
end