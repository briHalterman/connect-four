require_relative '../lib/board'

class Game
  def initialize
    @board = Board.new
    @players = [
      { name: "Player 1", symbol: "●" },
      { name: "Player 2", symbol: "○" }
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
      @board.print_board

      puts "#{current_player[:symbol]} #{current_player[:name]}, Go 4 it!"
      column = get_valid_column
      take_turn(column)
    end

    @board.print_board

    if @winner
      puts "#{current_player[:name]} wins! That's four in a row!"
    else
      puts "This time? Nobody ruled the row!"
    end
  end

  def get_valid_column
    loop do
      input = gets.chomp

      if input.match?(/^\d+$/) && (1..7).include?(input.to_i)
        column = input.to_i - 1

        if @board.grid[0][column] != nil
          puts "Column #{input} is full"
        else
          return column
        end
      else
        puts "Please choose a number between 1 and 7"
      end
    end
  end

  def play_again?
    loop do
      puts "Play again? (y/n): "
      input = gets.chomp.downcase
      return true if input == "y"
      return false if input == "n"
      puts "Please enter y or n"
    end
  end
end