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

  def initialize_game
    @game_pieces.each do |game_piece|
      position_piece game_piece
    end
  end

  def to_s
    @board.map do |row|
      row.map{|col| col.empty? ? '.' : col}.join(" ")
    end
  end

  private

  def position_piece game_piece
    placement = get_placement game_piece
    until valid_move? placement
      placement = get_placement game_piece
    end
    occupy_positions placement,game_piece
  end

  def valid_move? placement
      # Ensure that the planned move does not overlap any other ships on the board
      return false unless placement.map{|row,col| @board[row][col].empty? }.all?
      return true
  end

  def get_placement game_piece
    max_search_vals = {
      across: [@dimension - 1, @dimension - game_piece.size],
      down: [@dimension - game_piece.size, @dimension - 1]
    }
    offsets = { across: [0,1], down: [1,0]}
    orientation = [:across, :down].sample
    max_row_val, max_col_val = max_search_vals[orientation]
    row, col = [rand(0..max_row_val), rand(0..max_col_val)]
    dx, dy = offsets[orientation]
    placement = (0..game_piece.size - 1).map{|i| [row+i*dx, col+i*dy]}
    return placement
  end

  def occupy_positions placement,game_piece
    placement.map{|x,y| @board[x][y] = game_piece.icon}
  end

  # Create a dimension*dimension array with every entry initially set to ''
  def initialize_empty_board
    Array.new(@dimension){ Array.new(@dimension, '')}
  end
end
