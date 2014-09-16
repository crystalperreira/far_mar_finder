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
      @all_products << Product.new(product[0], product[1], product[2])
    end
    @all_products
  end

  def self.find(id)
    all.find {|product| product.id == id }
  end
  end
end
