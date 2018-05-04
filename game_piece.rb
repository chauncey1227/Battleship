class GamePiece

  attr_reader :name
  attr_reader :size
  attr_reader :icon

  def initialize(name, size)
    @name = name
    @size = size
    @icon = name[0].upcase
  end

end
