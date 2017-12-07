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

  describe("#update") do
    it("lets you update cities in the database") do
      new_city1 = City.new({:name => "Seattle", :id => nil})
      new_city1.save
      new_city1.update({:name => "Portland"})
      expect(new_city1.name).to(eq("Portland"))
    end
    it("lets you add a train to a city") do
      new_city = City.new({:name => "Seattle", :id => nil})
      new_city.save
      train1 = Train.new({:name => "train1", :id => nil})
      train1.save
      train2 = Train.new({:name => "train2", :id => nil})
      train2.save
      new_city.update({:train_ids => [train1.id, train2.id]})
      expect(new_city.trains).to(eq([train1, train2]))
    end
  end

  describe("#delete") do
    it("lets you delete a list from the database") do
      new_city1 = City.new({:name => "Seattle", :id => nil})
      new_city1.save
      new_city2 = City.new({:name => "Portland", :id => nil})
      new_city2.save
      new_city1.delete
      expect(City.all).to(eq([new_city2]))
    end
  end

  describe("#trains") do
    it("returns all of the trains in a particular city") do
      new_city = City.new({:name => "Seattle", :id => nil})
      new_city.save
      train1 = Train.new({:name => "train1", :id => nil})
      train1.save
      train2 = Train.new({:name => "train2", :id => nil})
      train2.save
      new_city.update({:train_ids => [train1.id, train2.id]})
      expect(new_city.trains).to(eq([train1, train2]))
    end
  end

end
