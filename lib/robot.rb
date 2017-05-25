#Grid directions

#SW    W    NW
#  X X X X X
#  X X X X X
#S X X X X X  N
#  X X X X X
#  X X X X X
#SE    E    NE

class RobotError < StandardError
end

class Robot

  attr_reader :grid, :position, :direction, :dir_names

  DIRECTIONS = {
    "NORTH"   =>  [0, 1],
    "SOUTH"   =>  [0, -1],
    "EAST"    =>  [1, 0],
    "WEST"    =>  [-1, 0]
  }

  def initialize
    @position = nil
    @direction = nil
    @dir_names = ["NORTH", "EAST", "SOUTH", "WEST"]
  end

  def report
    print position[0], ",", position[1], ",", direction, "\n"
  end

  def move
    @position = calculate_move
  end

  def turn_right
    @dir_names.rotate!
    @direction = dir_names[0]
  end

  def turn_left
    @dir_names.rotate!(-1)
    @direction = dir_names[0]
  end

  def place(x, y, direction)
    new_position = [x.to_i, y.to_i]

    unless valid_position?(new_position) && valid_direction?(direction)
      raise RobotError, "Position is out of bounds"
    end

    @position = new_position
    @direction = direction
    until dir_names[0] == direction
      dir_names.rotate!
    end
  end

  private

  def valid_position?(new_position)
    new_position.all? { |coord| coord.between?(0, 5) }
  end

  def valid_direction?(direction)
    dir_names.include?(direction)
  end

  def calculate_move
    new_position = [
      position[0] + DIRECTIONS[direction][0],
      position[1] + DIRECTIONS[direction][1]
    ]

    valid_position?(new_position) ? new_position : position
  end

end
