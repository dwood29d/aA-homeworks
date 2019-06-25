require_relative 'piece'
require 'byebug'

class Board
  attr_reader :grid

  def initialize
    fill_board
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def move_piece(start_pos, end_pos)
    raise "There is no piece at #{start_pos}" if self[start_pos].nil? # TODO: update to NullPiece when piece is fleshed out
    raise "You cannot move this piece to #{end_pos}" unless end_pos.all?{ |num| num.between?(0, 7) } && self[end_pos].nil?
    piece = self[start_pos]
    self[start_pos] = nil
    self[end_pos] = piece
  end

  def fill_board
    @grid = Array.new(8) { Array.new(8) }
    @grid.each_with_index do |row, i|
      if i < 2 || i > 5
        row.each_index { |j| row[j] = Piece.new }
      end
    end
  end

  def valid_pos(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end
end
