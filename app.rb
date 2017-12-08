require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/city")
require("./lib/train")
require("pg")


DB = PG.connect({:dbname => "train_system_test"})

get("/") do
  erb(:index)
end

get("/operator") do
  @cities = City.all
  @trains = Train.all
  erb(:operator)
end

get("/rider") do
  @trains = Train.all
  @cities = City.all
  erb(:rider)
end

get("/trains") do
  @trains = Train.all
  erb(:trains)
end

post("/trains") do
  name = params.fetch("train_name")
  new_train = Train.new({:name => name, :id => nil})
  new_train.save
  @trains = Train.all
  erb(:trains)
end

get("/trains/:id") do
  @train = Train.find(params.fetch("id").to_i)
  @cities = City.all
  erb(:train_info)
end

get("/rider/trains/:id") do
  @train = Train.find(params.fetch("id").to_i)
  @cities = City.all
  erb(:rider_train)
end

patch("/trains/:id") do
  train_id = params.fetch("id").to_i
  @train = Train.find(train_id)
  city_ids = params.fetch("city_ids")
  @train.update({:city_ids => city_ids})
  @cities = City.all
  erb(:train_info)
end

get("/cities") do
  @cities = City.all
  erb(:cities)
end

post("/cities") do
  name = params.fetch("city_name")
  new_city = City.new({:name => name, :id => nil})
  new_city.save
  @cities = City.all
  erb(:cities)
end

get("/cities/:id") do
  @city = City.find(params.fetch("id").to_i)
  @trains = Train.all
  erb(:city_info)
end

get("/rider/cities/:id") do
  @city = City.find(params.fetch("id").to_i)
  @trains = Train.all
  erb(:rider_city)
end

patch("/cities/:id") do
  city_id = params.fetch("id").to_i
  @city = City.find(city_id)
  train_ids = params.fetch("train_ids")
  @city.update({:train_ids => train_ids})
  @trains = Train.all
  erb(:city_info)
end
