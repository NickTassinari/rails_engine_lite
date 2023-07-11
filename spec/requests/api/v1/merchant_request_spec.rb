require 'rails_helper'

describe "Merchant API" do 
  it "sends list of merchants" do 
    create_list(:merchant, 100)
    @merchant_1 = create(:merchant)
    get '/api/v1/merchants'
    
    expect(response).to be_successful 
    expect(@merchant_1.name).to be_a(String)
    expect(response.parsed_body[0].name).to eq("sadl")
  end
end