class Food
  attr_reader :current_x, :current_y

  def initialize
    food_position
  end

  def food_position
    @current_x = (0..128).to_a.sample * 5
    @current_y = (0..96).to_a.sample * 5
  end

  def draw
    Gosu.draw_rect(@current_x, @current_y, 10, 10, Gosu::Color::RED)
  end
end
