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

  describe "#fired_upon?" do 
    it "allows a cell to be hit" do 
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to eq(false)
    end
  end

  describe "#fire_upon" do 
    it "changes cell status to fired_upon" do 
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)
      expect(cell.fired_upon?).to eq(false)
      expect(cell.ship.health).to eq(3)
      cell.fire_upon
      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to eq(true)
    end
  end
  
  describe "#render" do 
    it "displays status of the cell" do 
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")
      cell_2 = Cell.new("C3")
      cruiser = Ship.new("Cruiser", 3)
      cell_2.place_ship(cruiser)
      expect(cell_2.render).to eq(".")
      expect(cell_2.render(true)).to eq("S")
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")
      expect(cruiser.sunk?).to eq(false)
      cruiser.hit
      cruiser.hit
      expect(cruiser.sunk?).to eq(true)
      expect(cell_2.render).to eq("X")
    end
  end
end

