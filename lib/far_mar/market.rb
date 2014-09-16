module FarMar
  class Market
    attr_accessor :id, :name, :address, :city, :county, :state, :zip
    def initialize(id, name, address, city, county, state, zip)
      @id = id.to_i
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
      @all_markets << Market.new(market[0], market[1], market[2], market[3], market[4],market[5], market[6])
    end
    @all_markets
  end

  def self.find(id)
    all.find {|market| market.id == id }
  end

  def vendor(id)
    array = []
    FarMar::Vendor.each do |vendor|
      if vendor.market_id == id
        puts vendor
        array.push(vendor)
      end
      array
    end
  end
  end
end
