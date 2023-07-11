require 'rails_helper'

describe "Merchant API" do 
  it "sends list of merchants" do 
    create_list(:merchant, 3)

    get '/api/v1/merchants'
    
    expect(response).to be_successful 

    merchants = JSON.parse(response.body, symbolize_names: true)
# require 'pry'; binding.pry
    expect(merchants[:data].count).to eq(3)

  end
end