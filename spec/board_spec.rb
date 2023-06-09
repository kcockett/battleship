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
      expect(board.valid_coordinate?(["A2", "A3", "A4"])).to eq(true)
      expect(board.valid_coordinate?(["A2", "A31", "A4"])).to eq(false)

    end
  end
  describe "#valid_placement?" do 
    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
      @submarine = Ship.new("Submarine", 2)
    end
    it "can check number of coordinates is same as ship" do 
      expect(@board.valid_placement?(@cruiser, ["A1", "A2",])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A2", "A3", "A4"])).to eq(false)
    end
    it "can make sure coordinates are consecutive" do 
      expect(@board.valid_placement?(@cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["A1", "C1"])).to eq(false)
      expect(@board.valid_placement?(@cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C1", "B1"])).to eq(false)
    end
    it "coordinates cannot be diagonal" do 
      expect(@board.valid_placement?(@cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["C2", "D3"])).to eq(false)
    end
    it "all previous checks pass" do 
      expect(@board.valid_placement?(@submarine, ["A1", "A2"])).to eq(true)
      expect(@board.valid_placement?(@cruiser, ["B1", "C1", "D1"])).to eq(true)
    end
  end
  describe "#place method" do
    before(:each) do
      @board = Board.new
      @cruiser = Ship.new("Cruiser", 3)
    end
    it "can place ships into cells" do 
      @board.place(@cruiser, ["A1", "A2", "A3"])
      expect(cell_1 = @board.cells["A1"]).to eq(cell_1)
      expect(cell_2 = @board.cells["A2"]).to eq(cell_2)
      expect(cell_3 = @board.cells["A3"]).to eq(cell_3)
      expect(cell_1.ship).to eq(@cruiser)
      expect(cell_2.ship).to eq(@cruiser)
      expect(cell_3.ship).to eq(@cruiser)
      expect(cell_3.ship == cell_2.ship).to eq(true)
    end
    it 'checks for overlapping placement' do
      @submarine = Ship.new("Submarine", 2)
      @board.place(@cruiser, ["A1", "A2", "A3"])
      #require 'pry'; binding.pry
      expect(@board.valid_placement?(@submarine, ["A1", "B1"])).to eq(false)
      expect(@board.valid_placement?(@submarine, ["B1", "C1"])).to eq(true)
    end
  end
  describe "#render" do
    it "can render the board" do 
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      board.place(cruiser, ["A1", "A2", "A3"])
      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
      expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
    end
  end
end