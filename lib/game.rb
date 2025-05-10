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

  def current_player
    @players[@current_player_index]
  end

  def take_turn(column)
    @board.drop_piece(column, current_player[:symbol])

    if @board.winning_move?(current_player[:symbol])
      @winner = current_player[:symbol]
    else
      @current_player_index = (@current_player_index + 1) % 2
    end
  end

  def board_full?
    @board.grid.flatten.none?(&:nil?)
  end

  def play
    until @winner || board_full?
      puts "#{current_player[:name]} #{current_player[:symbol]}, Go for it!"
      column = gets.chomp.to_i
      take_turn(column)
    end

    if @winner
      puts "#{current_player[:name]} wins! That's four in a row!"
    else
      puts "This time? Nobody ruled the row!"
    end
  end
end