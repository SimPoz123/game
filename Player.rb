require "gosu"

class Player
  attr_reader :score

  def initialize
    @image = Gosu::Image.new("media/starfighter.bmp")
    @beep = Gosu::Sample.new("media/beep.wav")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
    @lives = 5
    @speed = 1.0
    @powered = false
    @count = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x * @speed
    @y += @vel_y * @speed
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)

    if @powered
      @speed = 2.0
      @count += 1
    else
      @speed = 1.0
      @count = 0
    end

    if @count == 300
      @powered = false
    end
  end

  def score
    @score
  end

  def lives
    @lives
  end

  def collect_stars(stars)
    stars.reject! do |star|
      if  Gosu::distance(@x, @y, star.x, star.y) < 35 then
        @score += 10
        @beep.play
        true
      else
        false
      end
    end
  end

  def interact_enemy(enemies)
    enemies.reject! do |enemy|
      if Gosu::distance(@x, @y, enemy.x + 30, enemy.y + 40) < 100
        @lives = @lives - 1
        true
      else
        false
      end
    end
  end

  def interact_power_up(power_ups)
    power_ups.reject! do |power_up|
      if Gosu::distance(@x, @y, power_up.x, power_up.y + 40) < 75
        @powered = true
        @count = 0
        true
      else
        false
      end
    end
  end
end
