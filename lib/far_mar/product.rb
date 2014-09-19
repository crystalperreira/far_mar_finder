module FarMar
  class Product
    attr_accessor :id, :name, :vendor_id
    def initialize(id, name, vendor_id)
      @id = id
      @name = name
      @vendor_id = vendor_id
    end

    # Used memoization for self.all

    @@all_products = []

    def self.all
      if @@all_products == []
        array_of_products = CSV.read("./support/products.csv")
        array_of_products.each do |product|
          @@all_products << Product.new(product[0].to_i, product[1], product[2].to_i)
        end
      end
      @@all_products
    end

    def self.find(id)
      all.find {|product| product.id == id }
    end

    def self.by_vendor(vendor_id)
      result = []
      self.all.each do |product|
        if product.vendor_id == vendor_id
          result << product
        end
      end
      result
    end

    def self.most_revenue(n)
      array = all.sort_by {|product| product.revenue}
      array.take(n)
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

    def revenue
      sale_total = 0
      FarMar::Sale.all.each do |sale|
        if sale.product_id == id
          sale_total += sale.amount
        end
      end
      sale_total
    end
  end
end
