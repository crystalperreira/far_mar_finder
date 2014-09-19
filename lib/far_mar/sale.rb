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

####### do this V

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
 # vendor - returns the FarMar::Vendor instance that is associated with this sale using the FarMar::Sale vendor_id field
    def vendor
      x =""
      FarMar::Vendor.all.each do |vendor|
        if vendor.id == self.vendor_id
          x = vendor
        end
      end
      x
    end

  #  product - returns the FarMar::Product instance that is associated with this sale using the FarMar::Sale product_id field
   def product
    x = ""
    FarMar::Product.all.each do |product|
      if product.id == self.product_id
        x = product
      end
    end
    x
   end

   # self.between(beginning_time, end_time) - returns a collection of FarMar::Sale objects where the purchase time is between the two times given as arguments

   ########################################################### FIX ME - datetime issues
   def self.between(beginning_time, end_time)
      sales_between=[]
      FarMar::Sale.all.each do |sale|
        if sale.purchase_time.between?(beginning_time, end_time)
          sales_between << sale
        end
      end
      sales_between
   end

  end
end


def change_date(date)
  require 'date'
  date = DateTime.parse(date).to_date
end
