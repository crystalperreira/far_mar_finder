module FarMar
  class Sale
    attr_accessor :id :amount :purchase_time :vendor_id :product_id
    def initialize(id, amount, purchase_time, vendor_id, product_id)
      @id = id
      @amount = amount
      @purchase_time = purchase_time
      @vendor_id = vendor_id
      @product_id = product_id
  end

  def self.all
    array_of_sales = CSV.read("/support/sales.csv")
    array_of_sales.each do |sale|
      Sale.new(sale[0], sale[1], sale[2], sale[3], sale[4])
    end
  end

  def self.find(id)
    array_of_sales = CSV.read("/support/sales.csv") 
    array_of_sales.find {|sale| sale[0] == id.to_s}
  end
end
