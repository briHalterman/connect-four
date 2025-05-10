require_relative '../lib/board'

RSpec.describe Board do
  describe "#initialize" do
    it "creates a 6x7 grid" do
      board = Board.new
      expect(board.grid.length).to eq(6)
      expect(board.grid.all? { |row| row.length == 7}).to be true
    end
  end
end