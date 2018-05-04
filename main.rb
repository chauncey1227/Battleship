require './game_board'

dimension = 10
gb = GameBoard.new dimension
gb.initialize_game
puts gb.to_s
