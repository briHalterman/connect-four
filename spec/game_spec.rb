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

  describe "#take_turn" do
    it "drops a piece for the current player in the given column" do
      game = Game.new
      game.take_turn(3)

      board = game.instance_variable_get(:@board)
      expect(board.grid[5][3]).to eq("🔴")
    end

    it "switches to the next player after a turn" do
      game = Game.new

      game.take_turn(3)
      current_index = game.instance_variable_get(:@current_player_index)

      expect(current_index).to eq(1)
    end

    it "detects a win immediately after a turn" do
      game = Game.new
      board = game.instance_variable_get(:@board)

      board.grid[5][0] = "🔴"
      board.grid[5][1] = "🔴"
      board.grid[5][2] = "🔴"

      game.take_turn(3)

      expect(game.instance_variable_get(:@winner)).to eq("🔴")
    end
  end
end