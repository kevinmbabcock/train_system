require('spec_helper')

describe(City) do

  describe("#initialize") do
    it("create a new city object") do
      new_city = City.new({:name => "Seattle", :id => nil})
      expect(new_city).to(be_an_instance_of(City))
    end
  end

  describe(".all") do
    it("is empty in the beginning") do
      expect(City.all).to(eq([]))
    end
  end

  describe("#save") do
    it("allows you to save cities to the database") do
      new_city = City.new({:name => "Seattle", :id => nil})
      new_city.save
      expect(City.all).to(eq([new_city]))
    end
  end

  describe("#==") do
    it("is the same city if it has the same name") do
      city1 = City.new({:name => "Seattle", :id => nil})
      city2 = City.new({:name => "Seattle", :id => nil})
      expect(city1).to(eq(city2))
    end
  end

  describe(".find") do
    it("returns a city by its ID") do
      new_city1 = City.new({:name => "Seattle", :id => nil})
      new_city1.save
      new_city2 = City.new({:name => "Portland", :id => nil})
      new_city2.save
      expect(City.find(new_city2.id)).to(eq(new_city2))
    end
  end


end
