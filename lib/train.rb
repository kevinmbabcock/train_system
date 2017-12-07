class Train
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(other_train)
    self.name.==(other_train.name).&(self.id.==(other_train.id))
  end

  def self.find(id)
    found_train = nil
    Train.all().each() do |train|
      if train.id().==(id)
        found_train = train
      end
    end
    found_train
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id};")

    attributes.fetch(:city_ids, []).each do |city_id|
      DB.exec("INSERT INTO stops (city_id, train_id) VALUES (#{city_id}, #{self.id});")
    end
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
    # DB.exec("DELETE FROM tasks WHERE list_id = #{self.id()};")
  end

  def cities
    stops = []
    results = DB.exec("SELECT city_id FROM stops WHERE train_id = #{self.id};")
    results.each do |result|
      city_id = result.fetch("city_id").to_i
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first.fetch("name")
      stops.push(City.new({:name => name, :id => city_id}))
    end
    stops
  end



end
