class Robot

  def initialize(direction=:east, x=0, y=0)
    @direction = direction
    @x = x
    @y = y
  end

  def orient(direction)
    raise ArgumentError.new if [:north, :south, :east, :west].include?(direction) == false
    bearing
    @direction = direction
  end

  def bearing
    @direction
  end

  def turn(dir)
    return dir == 'R' ? @direction = :east  : @direction = :west  if @direction == :north
    return dir == 'R' ? @direction = :south : @direction = :north if @direction == :east
    return dir == 'R' ? @direction = :north : @direction = :south if @direction == :west
    return dir == 'R' ? @direction = :west  : @direction = :east  if @direction == :south
  end

  def turn_left
    turn('L')
  end

  def turn_right
    turn('R')
  end

  def at(x, y)
    @x = x
    @y = y
    coordinates
  end

  def coordinates
    [@x , @y]
  end

  def advance
    @y += 1 if @direction == :north
    @x += 1 if @direction == :east
    @y -= 1 if @direction == :south
    @x -= 1 if @direction == :west
  end

  def place_robot(x, y, direction)
    @x = x
    @y = y
    @direction = direction
  end

end


class Simulator
  attr_accessor :x, :y, :direction

  def instructions(commands)
    output = []
    cmd_arr = commands.split("")
    cmd_arr.each do |command|
      output << [:turn_left]  if command == 'L'
      output << [:turn_right] if command == 'R'
      output << [:advance]    if command == 'A'
    end
    output.flatten!
  end

  def place(robot, x:, y:, direction:)
    robot.place_robot(x , y, direction)
  end

  def evaluate(robot, commands)
    cmd_arr = instructions(commands)
    cmd_arr.each do |command|
      robot.turn_right if command == :turn_right
      robot.turn_left  if command == :turn_left
      robot.advance    if command == :advance
    end
  end
end
