require_relative '../lib/board'

class Game
  def initialize
    @board = Board.new
    @players = [
      { name: "Player 1", symbol: "🔴" },
      { name: "Player 2", symbol: "🟡" }
    ]
    @current_player_index = 0
  end
end