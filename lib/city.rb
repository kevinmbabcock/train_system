class City
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(other_city)
    self.name.==(other_city.name).&(self.id.==(other_city.id))
  end

  def self.find(id)
    found_city = nil
    City.all.each do |city|
      if city.id.==(id)
        found_city = city
      end
    end
    found_city
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    @id = self.id
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{self.id};")

    attributes.fetch(:train_ids, []).each do |train_id|
      DB.exec("INSERT INTO stops(train_id, city_id) VALUES (#{train_id}, #{self.id});")
    end
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{self.id};")
  end

  def trains
    stops = []
    results = DB.exec("SELECT train_id FROM stops WHERE city_id = #{self.id};")
    results.each do |result|
      train_id = result.fetch("train_id").to_i
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first.fetch("name")
      stops.push(Train.new({:name => name, :id => train_id}))
    end
    stops
  end

end
