class Player
	def initialize(window)
	 @image = Gosu::Image.new(window, "imgs/pl.png", false)
	 @x = @y = @vel_y = @vel_x = @angle = 0.0
	 @direction = [0,0]
	 @score = 0
	 @step = 2
	 @blk = Array.new
	end
	
	def x
	 return @x
	end

	def y
	 return @y
	end

	def warp(x, y, blk)
	 @x, @y = x, y
	 @blk = blk
	end

	def turn_left
	 @direction = [-1*@step, 0]
	 if check(-1,0) == 0
  	   @x -= @step
	 end
	end
	
	def turn_right
	 @direction = [@step, 0]
	 if check(1,0) == 0
	   @x += @step
	 end
	end
	
	def turn_up
	 @direction = [0, -1*@step]
	 if check(-1,1) == 0
	   @y -= @step
	 end
	end
	
	def turn_down
	 @direction = [0, @step]
	 if check(1,1) ==0
	   @y += @step
	 end
	end

	def accelerate
	 @vel_x += Gosu::offset_x(@angle, 0.5)
	 @vel_y += Gosu::offset_y(@angle, 0.5)
	end

	def move
	 @x %= 640
	 @y %= 480
	end

	def showxy
#	 print "x=["+@x.to_s+"] y=["+@y.to_s+"] Direction = ["+@direction[0].to_s+","+@direction[1].to_s+"]\n"
	end

	def draw
	 @image.draw_rot(@x, @y, 1, 0)
	end
	
	def check(route, vert) #Check box crossing
	  i=0
	  res=0
	 if vert == 0
	  while i <@blk[0].size
	    if  (@x+route-@blk[0][i]-20).abs < 5 or  (@x+route-@blk[0][i]).abs < 5
		if (@y-@blk[1][i]).abs < 30 and @y>@blk[1][i]-10
		 res=1
		end
	    end
	    i +=1	
	  end
	 else
	  while i <@blk[0].size
	   if (@y+route-@blk[1][i]-20).abs < 10 or (@y+route-@blk[1][i]).abs < 10
		if (@x-@blk[0][i]).abs <30 and @x>@blk[0][i]-10
		 res =1
		end
	   end
	   i += 1
	  end
	 end
	  return res
	end
end
