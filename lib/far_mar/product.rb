module FarMar
  class Product
    attr_accessor :id, :name, :vendor_id
    def initialize(id, name, vendor_id)
      @id = id
      @name = name
      @vendor_id = vendor_id
    end

    def self.all
      @all_products = []
      array_of_products = CSV.read("./support/products.csv")
      array_of_products.each do |product|
        @all_products << Product.new(product[0].to_i, product[1], product[2].to_i)
      end
      @all_products
    end

    def self.find(id)
      all.find {|product| product.id == id }
    end

    def vendor
      x = ""
      FarMar::Vendor.all.each do |vendor|
        if vendor.id == vendor_id
          x = vendor
        end
      end
      x
    end

    def sales
      sales = []
      FarMar::Sale.all.each do |sale|
        if sale.product_id == id
          sales << sale
        end
      end
      sales
    end

    def number_of_sales
      sales.length
    end

    def self.by_vendor(vendor_id) #rspec issue here
      result = []
      self.all.each do |product| #changed to self from FarMar::Product
        if product.vendor_id == vendor_id
          result << product
        end
      end
      result
    end

  end
end
