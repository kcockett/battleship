require 'rspec'
require './ship'

describe "Ship" do
    describe '#initialize' do
        it "should initialize" do
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser).to be_a(Ship)
            expect(cruiser.name).to eq("Cruiser")
            expect(cruiser.length).to eq(3)
            expect(cruiser.health).to eq(cruiser.length)
        end
    end
    
end