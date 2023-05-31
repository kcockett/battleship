require 'rspec'
require './lib/game'

describe 'Game' do
  describe '#initialize' do
    it 'should initialize' do
      game = Game.new
      expect(game).to be_a(Game)
      expect(game.player_cruiser.name).to eq("Cruiser")
      expect(game.player_cruiser.length).to eq(3)
      expect(game.player_cruiser.health).to eq(3)
      expect(game.player_submarine.name).to eq("Submarine")
      expect(game.computer_submarine.name).to eq("Submarine")
      expect(game.computer_cruiser.name).to eq("Cruiser")
      expect(game.computer_board).to be_a(Board)
      expect(game.player_board).to be_a(Board)
      require 'pry'; binding.pry
    end
  end

  # describe '#start_ship_placement' do
  #   xit "should place computer ships" do
  #     game = Game.new
  #     game.start_ship_placement
  #     # How to test valid computer placements
  #   end
  # end

end