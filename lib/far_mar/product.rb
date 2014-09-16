module FarMar
  class Product
    attr_accessor :id, :name, :vendor_id
    def initialize(id, name, vendor_id)
      @id = id
      @name = name
      @vendor_id = vendor_id
      @sales = []
      @other_products = []
    end

    def self.all
      @all_products = []
      array_of_products = CSV.read("./support/products.csv")
      array_of_products.each do |product|
        @all_products << Product.new(product[0], product[1], product[2])
      end
      @all_products
    end

    def self.find(id)
      all.find {|product| product.id == id }
    end

    def vendor
      FarMar::Vendor.all.each do |vendor|
        if vendor.id == vendor_id
          vendor
        end
      end
    end

    def sales
      FarMar::Sale.all.each do |sale|
        if sale.product_id == id
          @sales << sale
        end
      end
      @sales
    end

    def number_of_sales
      @sales.length
    end

    def self.by_vendor(vendor_id) #rspec issue here
      self.all.each do |product| #changed to self from FarMar::Product
        if product.vendor_id == vendor_id
          @other_products << product
        end
      end
      @other_products
    end

  end
end
