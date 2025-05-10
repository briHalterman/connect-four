require_relative "../lib/game"

RSpec.describe Game do
  describe "#initialize" do
    it "creates a new board and two players" do
      game = Game.new
      expect(game.instance_variable_get(:@board)).to be_a(Board)
      players = game.instance_variable_get(:@players)
      expect(players.length).to eq(2)
      expect(players.first[:symbol]).to eq("🔴")
    end
  end
end