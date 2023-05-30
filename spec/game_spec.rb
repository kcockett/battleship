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
    end
  end
  # describe '#main_menu' do
  #   it 'should generate greeting message' do
  #     game.main_menu
  #   end
  # end
end