class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) }
  end

  def print_board
    @grid.each do |row|
      puts "|" + row.map { |cell| cell.nil? ? " " : cell }.join("|") + "|"
    end
    puts " 1 2 3 4 5 6 7"
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

  def four_in_a_row?(segment, symbol)
    segment.all? { |cell| cell == symbol }
  end

  def winning_move?(symbol)
    # Horizontal check
    @grid.each do |row|
      row.each_cons(4) do |segment|
        return true if four_in_a_row?(segment, symbol)
      end
    end

    # Vertical check
    (0..6).each do |column|
      column_cells = grid.map { |row| row[column] }
      column_cells.each_cons(4) do |segment|
        return true if four_in_a_row?(segment, symbol)
      end
    end

    # Diagonal check
    (3..5).each do |row|
      (0..3).each do |column|
        segment = [
          @grid[row][column],
          @grid[row - 1][column + 1],
          @grid[row - 2][column + 2],
          @grid[row - 3][column + 3]
        ]

        return true if four_in_a_row?(segment, symbol)
      end
    end

    # Diagonal check
    (3..5).each do |row|
      (3..6).each do |column|
        segment = [
          @grid[row][column],
          @grid[row - 1][column - 1],
          @grid[row - 2][column - 2],
          @grid[row - 3][column - 3]
        ]

        return true if four_in_a_row?(segment, symbol)
      end
    end

    false
  end
end