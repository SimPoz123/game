class Power

  attr_accessor :x, :y

  def initialize
    @image = Gosu::Image.new("media/power_up.png")
    @x = rand * 640
    @y = rand * 480
  end

  def draw
    @image.draw(@x, @y, 1)
  end

end
