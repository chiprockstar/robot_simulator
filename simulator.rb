class Robot

attr_reader :bearing


  def orient(direction)
    raise ArgumentError.new if [:north, :south, :east, :west].include?(direction) == false
    @bearing = direction
  end

  def turn(dir)
    return dir == 'R' ? @bearing = :east  : @bearing = :west  if @bearing == :north
    return dir == 'R' ? @bearing = :south : @bearing = :north if @bearing == :east
    return dir == 'R' ? @bearing = :north : @bearing = :south if @bearing == :west
    return dir == 'R' ? @bearing = :west  : @bearing = :east  if @bearing == :south
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
  end

  def coordinates
    [@x , @y]
  end

  def advance
    @y += 1 if @bearing == :north
    @x += 1 if @bearing == :east
    @y -= 1 if @bearing == :south
    @x -= 1 if @bearing == :west
  end

end


class Simulator
  attr_accessor :x, :y, :direction

  def instructions(commands)
      commands.chars.map do |command|
        if command == 'L'
          :turn_left
        elsif command == 'R'
          :turn_right
        elsif command == 'A'
          :advance
        end
      end
  end

  def place(robot, placement)
    robot.at(placement[:x], placement[:y])
      robot.orient(placement[:direction])
  end

  def evaluate(robot, commands)
      instructions(commands).each do |command|
      robot.send(command)
    end
  end
end
