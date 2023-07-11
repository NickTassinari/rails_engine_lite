require 'rails_helper'

describe "Merchant API" do 
  it "sends list of merchants" do 
    merchant = Merchant.create(name: "Target")
    merchant2 = Merchant.create(name: "AMCH")

    get '/api/v1/merchants'
    
    expect(response).to be_successful 

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(2)
    expect(merchants[:data][0][:attributes][:name]).to be_a(String)
    expect(merchants[:data][0][:attributes][:name]).to eq("Target")
    expect(merchants[:data][1][:attributes][:name]).to eq("AMCH")
  end

  it "can send single merchant data" do 
    merchant = Merchant.create(name: "Target")

    get "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful 
    
    merchants = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry

    expect(merchants[:data][:attributes][:name]).to be_a(String)
    expect(merchants[:data][:attributes][:name]).to eq("Target")



    
  end
end