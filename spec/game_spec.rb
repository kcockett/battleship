require 'rspec'
require './lib/game'

describe 'Game' do
  describe '#initialize' do
    it 'should initialize' do
      game = Game.new
      expect(game).to ba_a(Game)
    end
  end
end