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

  describe(".find") do
    it("returns a train by its ID") do
      new_train1 = Train.new({:name => "train1", :id => nil})
      new_train1.save()
      new_train2 = Train.new({:name => "train2", :id => nil})
      new_train2.save()
      expect(Train.find(new_train1.id())).to(eq(new_train1))
    end
  end

  describe("#update") do
    it("lets you update trains in the database") do
      new_train1 = Train.new({:name => "my_train", :id => nil})
      new_train1.save()
      new_train1.update({:name => "train1"})
      expect(new_train1.name()).to(eq("train1"))
    end
  end

  describe("#delete") do
    it("lets you delete a train from the database") do
      new_train1 = Train.new({:name => "my_train", :id => nil})
      new_train1.save()
      new_train2 = Train.new({:name => "train2", :id => nil})
      new_train2.save()
      new_train1.delete()
      expect(Train.all()).to(eq([new_train2]))
    end
    # it("deletes a train's tasks from the database") do
    #   train = Train.new({:name => "Epicodus stuff", :id => nil})
    #   train.save()
    #   task = Task.new({:description => "learn SQL", :train_id => train.id()})
    #   task.save()
    #   task2 = Task.new({:description => "Review Ruby", :train_id => train.id()})
    #   task2.save()
    #   train.delete()
    #   expect(Task.all()).to(eq([]))
    # end
  end

end
