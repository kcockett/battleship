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
    describe '#sunk?' do
        it "can check if ship has been destroyed" do
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser.sunk?).to eq(false)
        end
    end
    describe '#hit' do
        it "damage a ship" do
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser.health).to eq(3)
            cruiser.hit
            expect(cruiser.health).to eq(2)
        end
    end
end