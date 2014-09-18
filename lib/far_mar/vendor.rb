module FarMar
  class Vendor
    attr_accessor :id, :name, :no_of_employees, :market_id, :daily_revenue
    def initialize(id, name, no_of_employees, market_id)
      @id = id
      @name = name
      @no_of_employees = no_of_employees
      @market_id = market_id
      @daily_revenue = 0
    end

    def self.all
      @all_vendors = []
      array_of_vendors = CSV.read("./support/vendors.csv")
      array_of_vendors.each do |vendor|
        @all_vendors << Vendor.new(vendor[0].to_i, vendor[1], vendor[2].to_i, vendor[3].to_i)
      end
      @all_vendors
    end

    def self.find(id)
      all.find {|vendor| vendor.id == id }
    end

    def self.by_market(market_id)
      other_vendors = []
      self.all.each do |vendor|
        if vendor.market_id == market_id
          other_vendors << vendor
        end
      end
      other_vendors
    end

    def market
      x = ""
      FarMar::Market.all.each do |market|
        if market.id == market_id
          x = market
        end
      end
      x
    end


    def products
      products = []
      FarMar::Product.all.each do |product|
        if id == product.vendor_id
          products << product
        end
      end
      products
    end

    def sales
      sales = []
      FarMar::Sale.all.each do |sale|
        if sale.vendor_id == id
          sales << sale
        end
      end
      sales
    end

    def revenue
      sale_total = 0
      FarMar::Sale.all.each do |sale|
        if sale.vendor_id == id
          sale_total += sale.amount
        end
      end
      sale_total
    end



  end
end
