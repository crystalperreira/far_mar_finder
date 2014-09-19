module FarMar
  class Sale
    attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id
    def initialize(id, amount, purchase_time, vendor_id, product_id)
      @id = id
      @amount = amount
      @purchase_time = purchase_time
      @vendor_id = vendor_id
      @product_id = product_id
    end

    # Used memoization for self.all

    @@all_sales = []

    def self.all
      if @@all_sales == []
        array_of_sales = CSV.read("./support/sales.csv")
        array_of_sales.each do |sale|
          @@all_sales << Sale.new(sale[0].to_i, sale[1].to_i, change_date(sale[2]), sale[3].to_i, sale[4].to_i)
        end
      end
      @@all_sales
    end

    def self.find(id)
      all.find {|sale| sale.id == id }
    end

    def self.between(beginning_time, end_time)
      beginning_time = change_date(beginning_time)
      end_time = change_date(end_time)
      sales_between=[]
      FarMar::Sale.all.each do |sale|
        if sale.purchase_time.between?(beginning_time, end_time)
          sales_between << sale
        end
      end
      sales_between
    end

    def vendor
      x =""
      FarMar::Vendor.all.each do |vendor|
        if vendor.id == self.vendor_id
          x = vendor
        end
      end
      x
    end

    def product
      x = ""
      FarMar::Product.all.each do |product|
        if product.id == self.product_id
          x = product
        end
      end
      x
    end
  end
end

# We placed this outside of the class because it isn't associated with Sale
def change_date(date)
  require 'date'
  date = DateTime.parse(date)
end
