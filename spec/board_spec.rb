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
  end
end