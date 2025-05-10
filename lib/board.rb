class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def print_board
    @grid.each do |row|
      puts "|" + row.map { |cell| cell.nil? ? " " : cell }.join("|") + "|"
    end
    puts " 0 1 2 3 4 5 6"
  end

  def drop_piece(column, symbol)
    (5).downto(0) do |row|
      if @grid[row][column].nil?
        @grid[row][column] = symbol
        return true
      end
    end
    false
  end
end