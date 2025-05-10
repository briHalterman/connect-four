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

  def take_turn(column)
    current_player = @players[@current_player_index]
    @board.drop_piece(column, current_player[:symbol])
  end
end