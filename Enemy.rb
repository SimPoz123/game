class Enemy

  attr_accessor :x, :y

  def initialize(direction)
    @image = Gosu::Image.new("media/alien.bmp")
    if direction == 0
      @x = rand * 640
      if rand(2) == 0
        @vel_y = -8
        @y = 480
      else
        @vel_y = 8
        @y = 0
      end
      @vel_x = 0
    else
      @y = rand * 480
      if rand(2) == 0
        @vel_x = -8
        @x = 640
      else
        @vel_x = 8
        @x = 0
      end
      @vel_y = 0
    end
  end

  def move
    @x += @vel_x * 1.0
    @y += @vel_y * 1.0
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end
