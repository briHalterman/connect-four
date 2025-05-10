require_relative '../lib/board'

RSpec.describe Board do
  describe "#initialize" do
    it "creates a 6x7 grid" do
      board = Board.new
      expect(board.grid.length).to eq(6)
      expect(board.grid.all? { |row| row.length == 7}).to be true
    end
  end

  describe "#print_board" do
    it "prints a 6x7 empty grid to the terminal" do
      board = Board.new

      expected_output =
        "| | | | | | | |\n" * 6 +
        " 0 1 2 3 4 5 6\n"

      expect { board.print_board }.to output(expected_output).to_stdout
    end

    it "displays dropped pieces in the correct positions" do
      board = Board.new
      board.drop_piece(3, "🔴")
      board.drop_piece(3, "🟡")
      board.drop_piece(3, "🔴")

      expected_output =
        "| | | | | | | |\n" +  # row 0
        "| | | | | | | |\n" +  # row 1
        "| | | | | | | |\n" +  # row 2
        "| | | |🔴| | | |\n" +  # row 3
        "| | | |🟡| | | |\n" +  # row 4
        "| | | |🔴| | | |\n" +  # row 5
        " 0 1 2 3 4 5 6\n"

      expect { board.print_board }.to output(expected_output).to_stdout
    end
  end

  describe "#drop_piece" do
    it "places a symbol in the lowest empty row of a given column" do
      board = Board.new
      board.drop_piece(3, "🔴")
      expect(board.grid[5][3]).to eq("🔴")
    end

    it "stacks another symbol on top of the last" do
      board = Board.new
      board.drop_piece(3, "🔴")
      board.drop_piece(3, "🟡")
      expect(board.grid[5][3]).to eq("🔴")
      expect(board.grid[4][3]).to eq("🟡")
    end

    it "rejects a drop if the column is full" do
      board = Board.new
      board.drop_piece(3, "🔴")
      board.drop_piece(3, "🟡")
      board.drop_piece(3, "🔴")
      board.drop_piece(3, "🟡")
      board.drop_piece(3, "🔴")
      board.drop_piece(3, "🟡")
      result = board.drop_piece(3, "🔴")
      expect(result).to be false
      expect(board.grid[0][3]).to eq("🟡")
    end
  end

  describe "#winning_move?" do
    it "detects a horizontal win for 4 in a row" do
      board = Board.new
      board.drop_piece(0, "🔴")
      board.drop_piece(1, "🔴")
      board.drop_piece(2, "🔴")
      board.drop_piece(3, "🔴")

      expect(board.winning_move?("🔴")).to be true
    end

    it "detects a vertical win for 4 in a column" do
      board = Board.new
      board.drop_piece(0, "🔴")
      board.drop_piece(0, "🔴")
      board.drop_piece(0, "🔴")
      board.drop_piece(0, "🔴")

      expect(board.winning_move?( "🔴")).to be true
    end
  end
end