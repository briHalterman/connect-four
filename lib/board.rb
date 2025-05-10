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
end