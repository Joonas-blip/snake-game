require 'gosu'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Snake Game"
    @snake = Snake.new
    @food = Food.new
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)
    @play_again = false
  end

  def update
    if (Gosu.button_down? Gosu::KbUp) && @snake.sense != 'down'
      @snake.direction('up')
    elsif (Gosu.button_down? Gosu::KbDown) && @snake.sense != 'up'
      @snake.direction('down')
    elsif (Gosu.button_down? Gosu::KbRight) && @snake.sense != 'left'
      @snake.direction('right')
    elsif (Gosu.button_down? Gosu::KbLeft) && @snake.sense != 'rigth'
      @snake.direction('left')
    end
    movement
  end

  def movement
    @snake.move
    @snake.eat(@food)
    if @snake.snake[0][0] == 640 || @snake.snake[0][0].zero?
      end_game
    elsif @snake.snake[0][1] == 480 || @snake.snake[0][1].zero?
      end_game
    elsif @snake.dead == true
      end_game
    end
  end

  def score
    @font.draw_text("Score: #{@snake.score}", 0, 0, 1, 1.0, 1.0, Gosu::Color::WHITE)
  end

  def draw
    @snake.draw
    @food.draw
    score
    play_again_draw if @play_again == true
  end

  def end_game
    @play_again = true
  end

  def play_again_draw
    # display text == play again
    @font.draw_text("Play Again? \nyes = space \nclose game = Esc", 320, 230, 1, 1.0, 1.0, Gosu::Color::WHITE)
    if Gosu.button_down? Gosu::KbSpace
      initialize
    elsif Gosu.button_down? Gosu::KbEscape
      close
    end
  end
end

Game.new.show
