module FarMar
  class Vendor
    attr_accessor :id, :name, :employees, :market_id
    def initialize(id, name, employees, market_id)
      @id = id
      @name = name
      @employees = employees
      @market_id = market_id
      @sales = []
      @other_vendors = []
      @products = []
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

    def self.by_market(market_id)
      FarMar::Vendor.all.each do |vendor|
        if vendor.market_id == market_id
          @other_vendors << vendor
        end
      end
    end

    def market
      FarMar::Market.all.each do |market|
        if market.id == market_id
          puts market
        end
      end
    end


    def products(vendor)
      FarMar::Product.all.each do |product|
        if product.vendor_id == id
          @products << vendor
        end
      end
      @products
    end

    def sales_builder
      FarMar::Sale.all.each do |sale|
        if sale.vendor_id == id
          @sales << sale
        end
      end
      @sales
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
