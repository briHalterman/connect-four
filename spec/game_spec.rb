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

  describe "#current_player" do
    it "return the correct player based on the current index" do
      game = Game.new
      expect(game.current_player[:symbol]).to eq("🔴")

      game.instance_variable_set(:@current_player_index, 1)
      expect(game.current_player[:symbol]).to eq("🟡")
    end
  end

  describe "#play" do
    it "prints a winning message when the game is won" do
      game = Game.new
      board = game.instance_variable_get(:@board)

      board.grid[5][0] = "🔴"
      board.grid[5][1] = "🔴"
      board.grid[5][2] = "🔴"

      allow(game).to receive(:gets).and_return("3")

      expect { game.play }.to output(/Player 1 wins! That's four in a row!/).to_stdout
    end

    it "prints a draw message when the board is full and no one wins" do
      game = Game.new
      board = game.instance_variable_get(:@board)

      6.times do |row|
        7.times do |column|
          board.grid[row][column] = (row + column).even? ? "🔴" : "🟡"
        end
      end

      expect { game.play }.to output(/This time\? Nobody ruled the row!/).to_stdout
    end
  end
end