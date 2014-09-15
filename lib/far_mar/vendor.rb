module FarMar
  class Vendor
    attr_accessor :id :name :employees :market_id
    def initialize(id, name, employees, market_id)
      @id = id
      @name = name
      @employees = employees
      @market_id = market_id
  end

  def self.all
    array_of_vendors = CSV.read("/support/vendors.csv")
    array_of_vendors.each do |vendor|
      Vendor.new(vendor[0], vendor[1], vendor[2], vendor[3])
    end
  end

  def self.find(id)
    array_of_vendors = CSV.read("/support/vendors.csv")
    array_of_vendors.find {|vendor| vendor[0] == id.to_s}
  end

  def market(vendor)
    FarMar::Market.each do |market|
      if market[0] == vendor[3]
        puts vendor
      end
  end

  def products(vendor)
    array_of_products = []
    FarMar::Product.each do |product|
      if product[2] == vendor[0]
        array_of_products.push(vendor)
      end
      array_of_products
  end

  def sales(vendor)
    array_of_sales = []
    FarMar::Sale.each do |sale|
      if sale[3] == vendor[0]
        array_of_sales = []
      end
      array_of_sales
  end
end
