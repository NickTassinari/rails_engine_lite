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
    expect(items[:data][0][:attributes]).to have_key(:name)
    expect(items[:data][0][:attributes][:name]).to be_a(String)
    expect(items[:data][0][:attributes][:name]).to eq("item 9")

    expect(items[:data][0][:attributes]).to have_key(:description)
    expect(items[:data][0][:attributes][:description]).to be_a(String)
    expect(items[:data][0][:attributes][:description]).to eq("illegal")

    expect(items[:data][0][:attributes]).to have_key(:unit_price)
    expect(items[:data][0][:attributes][:unit_price]).to be_a(Float)
    expect(items[:data][0][:attributes][:unit_price]).to eq(9.75)

    expect(items[:data][0][:attributes]).to have_key(:merchant_id)
    expect(items[:data][0][:attributes][:merchant_id]).to be_a(Integer)
    expect(items[:data][0][:attributes][:merchant_id]).to eq(merchant.id)

    expect(items[:data][1][:attributes][:name]).to eq("item 10")
    expect(items[:data].count).to eq(2)
  end

  it "sends single item" do 
    merchant = Merchant.create!(name: "Target")
    item_9 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant.id)
    
    get "/api/v1/items/#{item_9.id}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data][:attributes][:name]).to eq("item 9")
    expect(items[:data][:attributes][:description]).to eq("illegal")
    expect(items[:data][:attributes][:unit_price]).to eq(9.75)
  end

  it "can create and then delete an item" do 
    merchant = Merchant.create!(name: "Target")
    item_params = ({
                    name: "Fender Jaguar",
                    description: "offset, single coil pickups, guitar",
                    unit_price: 400.99,
                    merchant_id: merchant.id
    })

    headers = { "CONTENT_TYPE" => "application/json "}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    jaguar = Item.last 

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(jaguar.name).to eq(item_params[:name])
    expect(jaguar.description).to eq(item_params[:description])
    expect(jaguar.unit_price).to eq(item_params[:unit_price])
    expect(jaguar.merchant_id).to eq(item_params[:merchant_id])

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{jaguar.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(jaguar.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can update existing item" do 
    merchant = Merchant.create!(name: "Target")
    jaguar = Item.create!( name: "Fender Jaguar",
      description: "offset, single coil pickups, guitar",
      unit_price: 400.99,
      merchant_id: merchant.id)
    
    edit_params = {  name: "Fender Jazzmaster",
      description: "offset, flat single coil pickups, guitar",
      unit_price: 1300.50,
      merchant_id: merchant.id}

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{jaguar.id}", headers: headers, params: JSON.generate({item: edit_params})

    item = Item.find_by(id: jaguar.id)

    expect(response).to be_successful
    expect(item.name).to_not eq("Fender Jaguar")
    expect(item.name).to eq("Fender Jazzmaster")
  end

  it "can update item with partial information" do 
    merchant = Merchant.create!(name: "Target")
    jaguar = Item.create!( name: "Fender Jaguar",
      description: "offset, single coil pickups, guitar",
      unit_price: 400.99,
      merchant_id: merchant.id)
    
    edit_params = {  name: "Fender Jazzmaster",
      description: "offset, flat single coil pickups, guitar"}

    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{jaguar.id}", headers: headers, params: JSON.generate({item: edit_params})

    item = Item.find_by(id: jaguar.id)

    expect(response).to be_successful
    expect(item.name).to_not eq("Fender Jaguar")
    expect(item.name).to eq("Fender Jazzmaster")
  end

  it "can get an items merchant info" do 
    merchant = Merchant.create!(name: "Target")
    jaguar = Item.create!( name: "Fender Jaguar",
      description: "offset, single coil pickups, guitar",
      unit_price: 400.99,
      merchant_id: merchant.id)

    get "/api/v1/items/#{jaguar.id}/merchant"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(item).to have_key(:data)
    expect(item[:data]).to be_a(Hash)
    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)
    expect(item[:data][:attributes][:name]).to eq(merchant.name)
    expect(item[:data][:id].to_i).to eq(merchant.id)
  end

  describe "sad path tests" do 
    it "returns 404 for wrong merchant id" do 
      merchant = Merchant.create!(name: "Target")
      jaguar = Item.create!( name: "Fender Jaguar",
                            description: "offset, single coil pickups, guitar",
                            unit_price: 400.99,
                            merchant_id: merchant.id)

      edit_params = {  name: "Fender Jazzmaster",
        description: "offset, flat single coil pickups, guitar",
        unit_price: 500.00,
        merchant_id: 500
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      patch "/api/v1/items/#{jaguar.id}", headers: headers, params: JSON.generate({item: edit_params})

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        # expect(Merchant.find(500)).to raise_error(ActiveRecord::RecordNotFound)
    end
  end




end