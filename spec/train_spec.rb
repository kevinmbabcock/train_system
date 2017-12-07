require('spec_helper')

describe(Train) do
  describe("#initialize") do
    it("creates a new train object") do
      new_train = Train.new({:name => "train1", :id => nil})
      expect(new_train).to(be_an_instance_of(Train))
    end
  end

  describe(".all") do
    it("is empty at first") do
      expect(Train.all).to(eq([]))
    end
  end

  describe("#save") do
    it("lets you save a train to the database") do
      new_train = Train.new({:name => "train1", :id => nil})
      new_train.save
      expect(Train.all).to(eq([new_train]))
    end
  end

  describe("#==") do
    it("is the same train if it is the same name") do
      new_train1 = Train.new({:name => "my_train", :id => nil})
      new_train2 = Train.new({:name => "my_train", :id => nil})
      expect(new_train1).to(eq(new_train2))
    end
  end

end
