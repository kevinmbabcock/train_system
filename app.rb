require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/city")
require("./lib/train")
require("pg")


DB = PG.connect({:dbname => "train_system"})

get("/") do
  erb(:index)
end

get("/operator") do
  @cities = City.all
  @trains = Train.all
  erb(:operator)
end

get("/rider") do
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
