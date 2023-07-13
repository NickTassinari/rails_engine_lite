require 'rails_helper'

describe "Merchant API" do 
  it "sends list of merchants" do 
    merchant = Merchant.create!(name: "Target")
    merchant2 = Merchant.create!(name: "AMCH")

    get '/api/v1/merchants'
    
    expect(response).to be_successful 
    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants).to have_key(:data)
    expect(merchants[:data]).to be_an(Array)
    expect(merchants[:data].count).to eq(2)
    expect(merchants[:data][0][:attributes][:name]).to be_a(String)
    expect(merchants[:data][0][:attributes][:name]).to eq("Target")
    expect(merchants[:data][1][:attributes][:name]).to eq("AMCH")
  end
  
  it "can send single merchant data" do 
    merchant = Merchant.create!(name: "Target")
    
    get "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful 
    expect(response.status).to eq(200)

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data][:attributes][:name]).to be_a(String)
    expect(merchants[:data][:attributes][:name]).to eq("Target")
    expect(merchants[:data][:id]).to eq(merchant.id.to_s)
  end

  it "can get merchants items" do 
    merchant = Merchant.create!(name: "Target")

    get "/api/v1/merchants/#{merchant.id}/items"
    expect(response).to be_successful 
    expect(response.status).to eq(200)
    
    merchants = JSON.parse(response.body, symbolize_names: true)
  end


  it "can find a merchant based on search" do 
    merchant_1 = Merchant.create!(name: "Sam Ash")
    merchant_2 = Merchant.create!(name: "Sweet Water")

    get "/api/v1/merchants/find?name=Sam"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(merchant[:data][:attributes]).to be_a(Hash)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
    expect(merchant[:data][:attributes][:name]).to eq(merchant_1.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(merchant_2.name)
  end
  
  it "can find a merchant based on partial match search" do 
    merchant_1 = Merchant.create!(name: "Sam Ash")
    merchant_2 = Merchant.create!(name: "Sweet Water")

    get "/api/v1/merchants/find?name=wee"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(merchant[:data][:attributes]).to be_a(Hash)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
    expect(merchant[:data][:attributes][:name]).to eq(merchant_2.name)
    expect(merchant[:data][:attributes][:name]).to_not eq(merchant_1.name)
  end

  it "returns 404 error if search is invalid" do 
    merchant_1 = Merchant.create!(name: "Sam Ash")
    merchant_2 = Merchant.create!(name: "Sweet Water")

    get "/api/v1/merchants/find?name="

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    expect(merchant[:data]).to eq(nil)
  end

  it "returns empty array if match is not found" do 
    merchant_1 = Merchant.create!(name: "Sam Ash")
    merchant_2 = Merchant.create!(name: "Sweet Water")

    get "/api/v1/merchants/find?name=guitar"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(merchant[:data][:id]).to eq(nil)

  end
end