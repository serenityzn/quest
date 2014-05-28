require 'rubygems'
require './inventory.rb'
require 'gosu'
require './player.rb'
require './level.rb'
require './bot.rb'
require './elements.rb'

module ZOrder
  Background, Stars, Player, UI = *0..3
end

class GameWindow < Gosu::Window
        def readlvl(lvl)
         bloks = Array.new
         bloks[0] = Array.new
         bloks[1] = Array.new
         i=0
         j=0
         open(lvl).each {|f|
           while j<32
                if f[j] == "x"
                 bloks[0]<< 20*j
                 bloks[1]<<20*(i-1)
                end
                j+=1
           end
         i+=1
         j=0
         }

         return bloks
        end

	def initialize
	 @bloks = Array.new
	 @bloks = readlvl('level.lvl')
	 size = @bloks[1].size
	 @inv_enable = false
	 @qi = 1
	 @wi = 1
	 @invdesc = ""
	 @sht_acc = 10
	 @sht_i = [0,0]
	 super 640, 480, false
	 self.caption = "QUEST"

	 @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
	 @bg_img = Gosu::Image.new(self, "imgs/grass_bg.jpg", true)
	 @pl = Player.new(self)
	 @pl.warp(320,240,@bloks)
	
	 @inv = Inventory.new(self)
	 @inv.warp(20,460)

	 @bot = Bot.new(self)
	 @bot.warp(250, 120, @bloks)

	 @level = Level.new(self,size)
	 @level.warp(@bloks)

	 @gun = Gun.new(self,"gun")
	 @gun.warp(40,40)
	 @gun1 = Gun.new(self,"gun")
	 @gun1.warp(40,100)
	 @gun2 = Gun.new(self,"gun")
	 @gun2.warp(100,100)
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
#	   @pl.turn_up
	   @pl.showxy
	   @pl.accelerate
	 end
	 
	 if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
	   @pl.deaccelerate
	   @pl.showxy
	 end

	


	 @pl.move
	 @pl.shoot
	 @gun.pickup(@pl.x,@pl.y,@inv)
	 @gun1.pickup(@pl.x,@pl.y,@inv)
	 @gun2.pickup(@pl.x,@pl.y,@inv)
	 @bot.move(@pl.x, @pl.y)
	end

	def draw
	 @pl.draw()
	 @bot.draw()
	 @level.draw()
	 @gun.draw()
	 @gun1.draw()
	 @gun2.draw()
	 @bg_img.draw(0,0,0)
	 if @inv_o == 10
	  @inv.draw()
	  @invdesc = @inv.get_name(@inv.get_num)
	  @invopt = @inv.get_opt(@inv.get_num)
	 end
	 #inventory description
	 @font.draw("#{@invdesc} : #{@invopt}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
	end

	def button_down(id)
	 if id == Gosu::KbEscape
	   close
	 end
	end
	
	def button_up(id)
	 if id == Gosu::KbI then
	  if @inv_enable == false
	   @inv_o = 10
	   @inv_enable = true
	  else
	   @inv_o = 0
	   @inv_enable = false
	  end
	 end
	 if id == Gosu::KbQ then
	     @inv.prev
	 end	 
	 if id == Gosu::KbW then
	     @inv.next
	 end	 
	 if id == Gosu::KbSpace then
	   if @inv.get_name(@inv.get_num) == "gun"
	    if @inv.get_opt(@inv.get_num) > 0
	     @pl.sht_start(@sht_acc)
	     @inv.update(@inv.get_num,@inv.get_opt(@inv.get_num)-1)
	    end
	   end
	 end
	end

end

window = GameWindow.new
window.show
	
