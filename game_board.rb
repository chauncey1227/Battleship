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
    operators = { across: '%', down: '/'}
    offset    = { across: [0,1], down: [1,0]}
    orientation = [:across, :down].sample
    # Get a location for the game_piece. Depending on the orientation,
    # limit the search space to empty locations where the piece could actually fit
    operator = operators[orientation]
    loc = (0...@dimension * @dimension).select.with_index do |x,i|
      i.public_send(operator, @dimension) <= game_piece.size
    end.sample
    row,col = [ loc / @dimension, loc % @dimension]
    dx, dy = offset[orientation]
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
