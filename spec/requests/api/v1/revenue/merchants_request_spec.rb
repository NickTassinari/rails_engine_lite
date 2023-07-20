require 'rails_helper'

RSpec.describe "revenue merchant request" do 
  describe "get merchants with most revenue desc" do 
    it "can get merchants with most revenue desc" do 

      merchant = Merchant.create!(name: "Target")
      merchant2 = Merchant.create!(name: "AMCH")
      merchant3 = Merchant.create!(name: "squams")
      merchant4 = Merchant.create!(name: "skinches")
      merchant5 = Merchant.create!(name: "tellarlaria")
      merchant6 = Merchant.create!(name: "quirk")
      merchant7 = Merchant.create!(name: "trellis")
      merchant8 = Merchant.create!(name: "bigg")
      merchant9 = Merchant.create!(name: "plao")
      merchant10 = Merchant.create!(name: "lirata")
      merchant11 = Merchant.create!(name: "bonkies")
      
      item_9 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant.id)
      item_10 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant2.id)
      item_11= Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant3.id)
      item_12 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant4.id)
      item_13 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant5.id)
      item_14 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant6.id)
      item_15 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant7.id)
      item_16 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant8.id)
      item_17 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant9.id)
      item_18 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant10.id)
      item_19 = Item.create!(name: "item 9", description: "illegal", unit_price: 9.75, merchant_id: merchant11.id)
      
      customer_1 = Customer.create!(first_name: "Jeffy", last_name: "Joey")
      
      invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant.id, status: 'shipped')
      invoice_item_1 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_1.id, quantity: 100, unit_price: 9.75)
      
      invoice_2 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant2.id, status: 'shipped')
      invoice_item_2 = InvoiceItem.create!(item_id: item_10.id, invoice_id: invoice_2.id, quantity: 100, unit_price: 9.75)
      
      invoice_3 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant3.id, status: 'shipped')
      invoice_item_3 = InvoiceItem.create!(item_id: item_11.id, invoice_id: invoice_3.id, quantity: 100, unit_price: 9.75)
      
      invoice_4 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant4.id, status: 'shipped')
      invoice_item_4 = InvoiceItem.create!(item_id: item_12.id, invoice_id: invoice_4.id, quantity: 100, unit_price: 9.75)
      
      invoice_5 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant5.id, status: 'shipped')
      invoice_item_5 = InvoiceItem.create!(item_id: item_13.id, invoice_id: invoice_5.id, quantity: 100, unit_price: 9.75)
      
      invoice_6 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant6.id, status: 'shipped')
      invoice_item_6 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_6.id, quantity: 100, unit_price: 9.75)
      
      invoice_7 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant7.id, status: 'shipped')
      invoice_item_7 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_7.id, quantity: 100, unit_price: 9.75)
      
      invoice_8 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant8.id, status: 'shipped')
      invoice_item_8 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_8.id, quantity: 100, unit_price: 9.75)
      
      invoice_9 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant9.id, status: 'shipped')
      invoice_item_9 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_9.id, quantity: 100, unit_price: 9.75)
      
      invoice_10 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant10.id, status: 'shipped')
      invoice_item_10 = InvoiceItem.create!(item_id: item_9.id, invoice_id: invoice_10.id, quantity: 100, unit_price: 9.75)
      
      get "/api/v1/revenue/merchants?quantity=10"
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end
    end
end