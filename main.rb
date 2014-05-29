require 'rubygems'
require './inventory.rb'
require 'gosu'
require './human.rb'
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
	 bloks[2] = Array.new
         i=0
         j=0
         open(lvl).each {|f|
           while j<32
                if f[j] == "x" or f[j] == "="
                 bloks[0]<< 20*j
                 bloks[1]<< 20*(i-1)
		 if f[j] == "x"
		  bloks[2]<< "x"
		 elsif f[j] == "="
		  bloks[2]<< "="
		 end
                end
                j+=1
           end
         i+=1
         j=0
         }

         return bloks
        end

	def initialize
	 @door_txt = Array.new
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
	 @pl = Player.new(self,["imgs/pl.png", "imgs/bullet.png"],4.5)
	 @pl.warp(320,240,@bloks)
	
	 @inv = Inventory.new(self)
	 @inv.warp(20,460)

	 @bot = Bot.new(self,["imgs/bot1.png", "imgs/bullet.png"],1)
	 @bot.warp(250, 120, @bloks)

	 @level = Level.new(self,size)
	 @level.warp(@bloks)

	 @gun = Gun.new(self,"imgs/gun.png")
	 @gun.warp(40,40)
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
	 @door_txt = @level.chk_near_door(@pl.x, @pl.y)
	 @pl.move
	 @pl.shoot
	 @gun.pickup(@pl.x,@pl.y,@inv)
	 @bot.move(@pl.x, @pl.y)
	end

	def draw
	 @pl.draw()
	 @bot.draw()
	 @level.draw()
	 @gun.draw()
	 @bg_img.draw(0,0,0)
	 if @inv_o == 10
	  @inv.draw()
	  @invdesc = @inv.get_name(@inv.get_num)
	  @invopt = @inv.get_opt(@inv.get_num)
	 end
	 #inventory description
	 @font.draw("#{@invdesc} : #{@invopt}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
	 @font.draw("#{@door_txt[0]}", 300, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
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
	   elsif @inv.get_name(@inv.get_num) == "key" 
	     if @door_txt[0] != ""
	      if @door_txt[1] == "Closed"
	       @level.open_door
	      else
	       @level.close_door
	      end
	     end
	   end
	 end
	 if id == Gosu::KbD then
	  @level.doors
	 end
	end

end

window = GameWindow.new
window.show
	
