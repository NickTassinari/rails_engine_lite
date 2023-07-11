require 'rails_helper'

RSpec.describe "Items API" do 
  it "sends list of items" do 
    merchant = Merchant.create!(name: "Target")
    merchant2 = Merchant.create!(name: "AMCH")

    item_9 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant.id)
    item_2 = Item.create!(name: "item 10", description: "illegal", unit_price: 3.50, merchant_id: merchant2.id)

    get "/api/v1/items"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data]).to be_an(Array)
    expect(items[:data][0][:attributes][:name]).to be_a(String)
    expect(items[:data][0][:attributes][:name]).to eq("item 9")
    expect(items[:data][1][:attributes][:name]).to eq("item 10")
    expect(items[:data].count).to eq(2)
  end

  
end