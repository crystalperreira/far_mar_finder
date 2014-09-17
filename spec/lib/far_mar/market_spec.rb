require 'spec_helper'
describe FarMar::Market do

  describe "class methods" do
    it "responds to 'all'" do
      expect(FarMar::Market).to respond_to :all
    end

    it "'all' should return" do
      expect(FarMar::Market.all.count).to eq 500
    end

    it "responds to 'find'" do
      expect(FarMar::Market).to respond_to :find
    end
  end

  describe "attributes" do
    let(:market) { FarMar::Market.find(1) }
    # 1,People's Co-op Farmers FarMar::Market,30,Portland,Multnomah,Oregon,97202

    it "has the id 1" do
      expect(market.id).to eq 1
    end
#Test for products method
    # it "finds the id of the first product available at market 1" do
    #   expect(FarMar::Product.vendor.market.first.name).to eq "Dry Beets"
    # end
###
    it "has the name 'People's Co-op Farmers FarMar::Market'" do
      expect(market.name).to eq "People's Co-op Farmers Market"
    end

    it "has the address '30th and Burnside'" do
      expect(market.address).to eq "30th and Burnside"
    end

    it "has the city 'Portland'" do
      expect(market.city).to eq "Portland"
    end
    it "has the county 'Multnomah'" do
      expect(market.county).to eq "Multnomah"
    end
    it "has the state 'Oregon'" do
      expect(market.state).to eq "Oregon"
    end
    it "has the zip '97202'" do
      expect(market.zip).to eq "97202"
    end

  end

 # describe "instance methods" do
 #   let(:market) { FarMar::Market.find(1) }
 #   it "responds to vendors" do
 #     expect(FarMar::Market.new([])).to respond_to :vendors
 #   end

     describe "instance methods" do
       let(:market) { FarMar::Market.find(1) } # added quotes
       it "responds to vendors" do
         expect(market).to respond_to :vendors
       end

    it "finds the vendors" do
      expect(market.vendors.first.id.to_i).to eq 1 # added .to_i
    end
  end
end
