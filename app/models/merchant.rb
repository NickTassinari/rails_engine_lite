class Merchant < ApplicationRecord
  has_many :items 
  has_many :invoices 
  has_many :invoice_items, through: :invoices 
  has_many :customers, through: :invoices 
  has_many :transactions, through: :invoices 

  def self.find_name(search_params)
    where('name ILIKE ?', "%#{search_params}%").order(name: :asc)
  end

  def self.top_merchants_by_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .select(:name, :id, 'SUM(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(quantity)
  end
end
