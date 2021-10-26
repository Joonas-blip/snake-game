require_relative 'food'

class Snake
  attr_reader :snake, :score, :play_again

  def initialize
    @sense = 'up'
    @snake = [[310, 230]]
    @speed = 5
    @food = Food.new
    @score = 0
    @play_again = false
    @dead = false
  end

  def sense
    @sense
  end

  def dead
    @dead
  end

  def direction(dir)
    @sense = dir
  end

  def move
    current_x = @snake[0][0]
    current_y = @snake[0][1]
    new_position = []
    case @sense
    when 'right'
      current_x += @speed
      new_position << current_x
      new_position << current_y
    when 'left'
      current_x -= @speed
      new_position << current_x
      new_position << current_y
    when 'up'
      current_y -= @speed
      new_position << current_x
      new_position << current_y
    when 'down'
      current_y += @speed
      new_position << current_x
      new_position << current_y
    end
    @head = new_position
    if @snake.include? @head
      @dead = true
      return
    else
      @snake.insert(0, new_position)
      @snake.pop unless @add_square == true
      @add_square = false
    end
  end

  def draw
    @snake.each do |x, y|
      Gosu.draw_rect(x, y, 10, 10, Gosu::Color::WHITE)
    end
  end

  def eat(food)
    @snake.each do |x, y|
      if [x, y] == [food.current_x, food.current_y]
        food.food_position
        @add_square = true
        @score += 1
      end
    end
  end
end
