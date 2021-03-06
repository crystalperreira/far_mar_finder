require 'io/console'
require 'date'

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

    # Used memoization for self.all

    @@all_markets = []

    def self.all
      if @@all_markets == []
        array_of_markets = CSV.read("./support/markets.csv")
        array_of_markets.each do |market|
          @@all_markets << Market.new(market[0].to_i, market[1], market[2], market[3], market[4],market[5], market[6])
        end
    end
    @@all_markets
  end

  def self.find(id)
    all.find {|market| market.id == id }
  end

  def self.search(search_term)
    array = []
    self.all.each do |market_instance|
      if market_instance.name.downcase == search_term.downcase
        array << market_instance
      end
    end

    self.all.each do |market_instance|
      market_instance.vendors.each do |vendor|
        if vendor.name.downcase == search_term.downcase
          array << market_instance
        end
      end
    end
    array
  end

  # We changed the name from preferred_vendor
  # We included _date to prevent mixup w/ similarly named method
  def preferred_vendor_date(my_date)
    max = 0
    pref_vend = ""
    FarMar::Vendor.all.each do |vendor|
      if vendor.market_id == id && vendor.daily_revenue(my_date) > max
        max = vendor.daily_revenue(my_date)
        pref_vend = vendor
      end
    end
    pref_vend
  end

  # We changed the name from worst_vendor
  # We included _date to prevent mixup w/ similarly named method
  def worst_vendor_date(my_date)
    max = 9000000
    pref_vend = ""
    FarMar::Vendor.all.each do |vendor|
      if vendor.market_id == id && vendor.daily_revenue(my_date) < max
        max = vendor.daily_revenue(my_date)
        pref_vend = vendor
      end
    end
    pref_vend
  end

  def preferred_vendor
    x = 0
    pref_vendor = ""
    FarMar::Vendor.all.each do |vendor|
      if id == vendor.market_id && vendor.revenue > x
        x = vendor.revenue
        pref_vendor = vendor
      end
    end
    pref_vendor
  end

  def worst_vendor
    x = 99999999999
    pref_vendor = ""
    FarMar::Vendor.all.each do |vendor|
      if id == vendor.market_id && vendor.revenue < x
        x = vendor.revenue
        pref_vendor = vendor
      end
    end
    pref_vendor
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
