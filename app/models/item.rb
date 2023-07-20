class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy 
  has_many :invoices, through: :invoice_items

  def self.find_by_name(params)
    return false if params[:name].nil?
    return false if params[:name].empty? 

    Item.where("name ILIKE '%#{params[:name]}%'")
  end
end