module FarMar
  class Vendor
    attr_accessor :id, :name, :employees, :market_id
    def initialize(id, name, employees, market_id)
      @id = id
      @name = name
      @employees = employees
      @market_id = market_id
  end

  def self.all
    @all_vendors = []
    array_of_vendors = CSV.read("./support/vendors.csv")
    array_of_vendors.each do |vendor|
      @all_vendors << Vendor.new(vendor[0], vendor[1], vendor[2], vendor[3])
    end
    @all_vendors
  end

  def self.find(id)
    all.find {|vendor| vendor.id == id }
  end

  def market(vendor)
    FarMar::Market.each do |market|
      if market.id == vendor.market_id
        puts vendor
      end
    end
  end


  def products(vendor)
    array_of_products = []
    FarMar::Product.each do |product|
      if product.vendor_id == vendor.id
        array_of_products.push(vendor)
      end
      array_of_products
    end
  end

  def sales(vendor)
    array_of_sales = []
    FarMar::Sale.each do |sale|
      if sale.vendor_id == vendor.id
        array_of_sales = []
      end
      array_of_sales
    end
  end
  end
end
