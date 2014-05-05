class Level
	def initialize(window, size)
	 @image = Gosu::Image.new(window, "imgs/bl.png", false)
	 @x = @y = 0
	 @bloks = Array.new
	 @bloks[0] = Array.new
	 @bloks[1] = Array.new
	 @max = size
	end

	def warp(xy)
	 @bloks = xy
	end

	def draw
#	 print "MAXXXX= "+@max.to_s
	 i = 0
	 while i<@max
	   @image.draw_rot(@bloks[0][i]+10, @bloks[1][i]+10, 1, 0)
	   i +=1
	 end
	end
end
