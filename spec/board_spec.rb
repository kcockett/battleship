require './board.rb'
#require './lib/cell'
#require './lib/ship'
require 'rspec'

describe "Board" do
  describe "#initialize" do
    it 'creates a board object with default coordinate hash' do
      board = Board.new
      expect(board).to be_a(Board)
      expect(board.cells).to be_a(Hash)
      expect(board.cells.size).to eq(16)
    end
  end
  describe "#valid_coordinate?" do
    it 'returns true if coordinate is valid' do
      board = Board.new
      expect(board.valid_coordinate?("A1")).to eq(true)
      expect(board.valid_coordinate?("D4")).to eq(true)
      expect(board.valid_coordinate?("A5")).to eq(false)
      expect(board.valid_coordinate?("E1")).to eq(false)
      expect(board.valid_coordinate?("A22")).to eq(false)
    end
  end
  describe "#valid_placement?" do 
    it "can check number of coordinates is same as ship" do 
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A1", "A2",])).to eq(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
    end
    it "can make sure coordinates are consecutive" do 
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
    end
  end
end