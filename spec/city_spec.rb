require('spec_helper')

describe(City) do

  describe("#initialize") do
    it("create a new city object") do
      new_city = City.new({:name => "Seattle", :id => nil})
      expect(new_city).to(be_an_instance_of(City))
    end
  end




end
