require 'rspec'
require './lib/ship'
require './lib/cell'

describe "Cell" do 
  describe "#initialize" do
    it "initializes" do 
      cell = Cell.new("B4")
      expect(cell).to be_a(Cell)
      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to be(nil)
    end
  end

  describe "#empty?" do 
    it "checks if cell is empty" do 
      cell = Cell.new("B4")
      expect(cell.empty?).to eq(true)
    end
  end

  describe "#place_ship" do 
    it "places a ship object into a cell object" do
      cruiser = Ship.new("Cruiser", 3)
      cell = Cell.new("B4")
      cell.place_ship(cruiser)
      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to eq(false)
    end
  end
end

