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
end

