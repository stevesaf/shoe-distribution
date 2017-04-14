require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  erb(:index)
end

get("/brands") do
  @brands = Brand.all()
  erb(:brands)
end

get("/brands/:id") do
  @brand = Brand.find(params.fetch("id").to_i())
  @stores = Store.all()
  erb(:brand)
end

get("/stores/:id") do
  @store = Store.find(params.fetch("id").to_i())
  @brands = Brand.all()
  erb(:store)
end

get("/stores") do
  @stores = Store.all()
  erb(:stores)
end

post("/stores") do
  name = params.fetch("name")
  Store.create({:name => name})
  redirect("/stores")
end

post("/brands") do
  name = params.fetch("name")
  Brand.create({:name => name})
  redirect("/brands")
end

patch("/brands/:id") do
  brand_id = params.fetch("id").to_i()
  @brand = Brand.find(brand_id)
  store_ids = params.fetch("store_ids") #this is coming from our store_ids[] we created in the name for the checkboxes
  @brand.update({:store_ids => store_ids})
  @stores = Store.all()
  erb(:brand)
end

patch("/stores/:id") do
  store_id = params.fetch("id").to_i()
  @store = Store.find(store_id)
  brand_ids = params.fetch("brand_ids") #this is coming from our store_ids[] we created in the name for the checkboxes
  @store.update({:brand_ids => brand_ids})
  @brands = Brand.all()
  erb(:store)
end
