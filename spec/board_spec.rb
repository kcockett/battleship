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
end