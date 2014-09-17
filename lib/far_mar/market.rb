require 'io/console'

module FarMar
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip
    def initialize(id, name, address, city, county, state, zip)
      @id = id
      @name = name
      @address = address
      @city = city
      @county = county
      @state = state
      @zip = zip
    end

  def self.all
    @all_markets = []
    array_of_markets = CSV.read("./support/markets.csv")
    array_of_markets.each do |market|
      @all_markets << Market.new(market[0].to_i, market[1], market[2], market[3], market[4],market[5], market[6])
    end
    @all_markets
  end

  def self.find(id)
    all.find {|market| market.id == id }
  end

  ################
  def self.search(search_term)
          array = []
          self.all.each do |market_instance|
                  if market_instance.name.downcase == search_term.downcase
                          array << market_instance
                  end
                  market_instance.vendors.each do |instance_piece|
                          if instance_piece.downcase == search_term.downcase
                                  array << market_instance
                          end
                  end
          end
          array
  end

  def products
    all_products = []
    FarMar::Vendor.all.each do |vendor|
      if vendor.market_id == id
        all_products << vendor.products
      end
    end
    all_products.flatten!
  end

  def vendors
    array = []
    FarMar::Vendor.all.each do |vendor|
      if vendor.market_id == id # trying to get this from market instance
         array << vendor
      end
    end
    array
  end

  end
end
