require('spec_helper')

describe(Train) do
  describe("#initialize") do
    it("creates a new train object") do
      new_train = Train.new({:name => "train1", :id => nil})
      expect(new_train).to(be_an_instance_of(Train))
    end
  end
end
