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

  def self.all
    @all_sales = []
    array_of_sales = CSV.read("./support/sales.csv")
    array_of_sales.each do |sale|
      @all_sales << Sale.new(sale[0], sale[1], sale[2], sale[3], sale[4])
    end
    @all_sales
  end
    def self.find(id)
      all.find {|sale| sale.id == id }
    end
end
end
