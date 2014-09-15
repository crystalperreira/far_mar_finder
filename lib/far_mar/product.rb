module FarMar
  class Product
    attr_accessor :id :name :vendor_id
    def initialize(id, name, vendor_id)
      @id = id
      @name = name
      @vendor_id = vendor_id

  end

  def self.all
    array_of_products = CSV.read("/support/products.csv")
    array_of_products.each do |product|
      Product.new(product[0], product[1], product[2])
    end
  end

  def self.find(id)
    array_of_products = CSV.read("/support/products.csv") 
    array_of_products.find {|product| product[0] == id.to_s}
  end
end
