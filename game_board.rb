require './tug'
require './destroyer'
require './submarine'
require './battleship'
require './cruiser'

class GameBoard
  def initialize(dimension = 10)
    @dimension = dimension
    @game_pieces =  [Cruiser.new, Battleship.new, Submarine.new, Destroyer.new, Tug.new]
    @board = initialize_empty_board
  end

  def to_s
    @board.map do |row|
      row.map{|col| col.empty? ? '.' : col}.join(" ")
    end
  end

  private

  # Create a dimension*dimension array with every entry initially set to ''
  def initialize_empty_board
    Array.new(@dimension){ Array.new(@dimension, '')}
  end
end
