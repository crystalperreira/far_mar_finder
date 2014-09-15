module FarMar
  class Market
    attr_accessor :id :name :address :city :county :state :zip
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
    array_of_markets = CSV.read("/support/markets.csv")
    array_of_markets.each do |market|
      Market.new(market[0], market[1], market[2], market[3], market[4],market[5], market[6])
    end
  end

  def self.find(id)
    array_of_markets = CSV.read("/support/markets.csv")
    array_of_markets.find {|market| market[0] == id.to_s}
  end

  def vendor(id)
    FarMar::Vendor.each do |vendor|
      array = []
      if vendor[3] == id
        array.push(vendor)
      end
      array
    end
  end
end
