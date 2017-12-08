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
