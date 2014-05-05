require 'rubygems'
require 'gosu'
require 'player.rb'
require 'level.rb'
require 'bot.rb'

class GameWindow < Gosu::Window
	def initialize
	 @bloks = Array.new
         @bloks[0] = [0, 20, 100, 120, 420, 300, 100]
         @bloks[1] = [0, 20, 40, 100, 160, 120, 200]
	 size = @bloks[1].size

	 super 640, 480, false
	 self.caption = "QUEST"

	 @bg_img = Gosu::Image.new(self, "imgs/grass_bg.jpg", true)
	 @pl = Player.new(self)
	 @pl.warp(320,240,@bloks)
	
	 @bot = Bot.new(self)
	 @bot.warp(250, 120, @bloks)

	 @level = Level.new(self,size)
	 @level.warp(@bloks)
	end

	def update
	 if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
	   @pl.turn_left
	   @pl.showxy
	 end
	 
	 if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
	   @pl.turn_right
	   @pl.showxy
	 end
	 
	 if button_down? Gosu::KbUp or button_down? Gosu::GpUp then
	   @pl.turn_up
	   @pl.showxy
	 end
	 
	 if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
	   @pl.turn_down
	   @pl.showxy
	 end

	 @pl.move
	 @bot.move(@pl.x, @pl.y)
	end

	def draw
	 @pl.draw()
	 @bot.draw()
	 @level.draw()
	 @bg_img.draw(0,0,0)
	end

	def button_down(id)
	 if id == Gosu::KbEscape
	   close
	 end
	end
end

window = GameWindow.new
window.show
	
