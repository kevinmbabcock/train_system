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
