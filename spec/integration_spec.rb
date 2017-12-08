require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("operators viewing all trains and cities", {:type => :feature}) do
  it("allows an operator to view all trains and cities in database") do
    visit('/')
    click_link('Click here for operators')
    expect(page).to have_content('Hello Operator')
  end
end

describe("riders viewing all trains and cities", {:type => :feature}) do
  it("allows riders to view all trains and cities in database") do
    visit('/')
    click_link('Click here for rider info')
    expect(page).to have_content("Hello Epicodus Train Riders")
  end
end

describe("operators adding trains", {:type => :feature}) do
  it("allows an operator to add new trains to database") do
    visit('/operator')
    click_link('Click here to add new train')
    expect(page).to have_content('Add an train to the database:')
  end
end

describe("operators adding cities", {:type => :feature}) do
  it("allows an operator to add new cities to database") do
    visit('/operator')
    click_link('Click here to add new city')
    expect(page).to have_content('Add an city to the database:')
  end
end

describe("operators adding cities to trains", {:type => :feature}) do
  it("allows an operator to select the cities a particular train will stop") do
    visit('/trains')
    fill_in('train_name', :with => 'train1')
    click_button("Add Train")
    visit('/operator')
    click_link('train1')
    expect(page).to have_content('train1')
  end
end

describe("operators adding trains to cities", {:type => :feature}) do
  it("allows an operator to select the trains that will stop in a particular city") do
    visit('/cities')
    fill_in('city_name', :with => 'Seattle')
    click_button("Add city")
    visit('/operator')
    click_link('Seattle')
    expect(page).to have_content('Seattle')
  end
end
