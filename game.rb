require "gosu"
require './player'
require './star'
require './enemy'
require './power'

class GameWindow < Gosu::Window

  def initialize
    super 640, 480, false
    self.caption = "The Very Best Game"

    @background_image = Gosu::Image.new("media/space.png", :tiletable => true)

    @player = Player.new
    @player.warp(320, 240)

    @star_anim = Gosu::Image.load_tiles("media/star.png", 25, 25)
    @stars = Array.new
    @enemies = Array.new
    @power_ups = Array.new

    @font = Gosu::Font.new(20)
  end

  def update
    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
      @player.turn_right
    end
    if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    @player.move
    @player.collect_stars(@stars)
    @player.interact_enemy(@enemies)
    @player.interact_power_up(@power_ups)


    if rand(100) < 4 && @stars.size < 25
      @stars.push(Star.new(@star_anim))
    end

    if rand(400) < 3 && @enemies.size < 4
      @enemies.push(Enemy.new(rand(2)))
    end

    if rand(500) == 1 && @power_ups.size == 0
      @power_ups.push(Power.new)
    end

    @enemies.each do |enemy|
      enemy.move
      if enemy.x > 660 || enemy.x < -20 || enemy.y > 500 || enemy.y < -20
        @enemies.delete(enemy)
      end
    end
  end

  def draw
    if @player.lives <= 0
      lose = true
    else
      lose = false
    end

    if lose
      @font.draw("Game Over!", 260, 240, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
      @font.draw("Your score was: #{@player.score}", 260, 160, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
    else
      @player.draw
      @background_image.draw(0, 0, ZOrder::Background)
      @stars.each { |star| star.draw}
      @enemies.each { |enemy| enemy.draw}
      @power_ups.each { |power_up| power_up.draw}
      @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
      @font.draw("Lives Left: #{@player.lives}", 530, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00)
    end
  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end

end

module ZOrder
  Background, Stars, Player, UI = *0..3
end


window = GameWindow.new
window.show
