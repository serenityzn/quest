class Inventory
	def initialize(window)
	 @image = Array.new
	 @ramka = Gosu::Image.new(window, "imgs/ramka.png", false)
	 #@image << Gosu::Image.new(window, "imgs/card.png", false)
	 @size = 6
	 @n_el = 0
	 @x = @y = 0.0
	 @blk = Array.new
	 @window = window
	end
	
	def add(element)
	 @image << Gosu::Image.new(@window, "imgs/"+element+".png", false)
	end

	def x
	 return @x
	end

	def y
	 return @y
	end
	
	def next
	 if @n_el < @image.size
	  @n_el += 1
	 else
	  @n_el = 0
	 end
	end

	def warp(x, y)
	 @x, @y = x, y
	 add("card")
	 add("gun")
	end

	def showxy
#	 print "x=["+@x.to_s+"] y=["+@y.to_s+"] Direction = ["+@direction[0].to_s+","+@direction[1].to_s+"]\n"
	end

	def draw
          i=0
	 while i<@image.size
	  @image[i].draw_rot(@x+i*40, @y, 1, 0)
	  i += 1
	 end
	 @ramka.draw_rot(@x+@n_el*40,@y,1,0)
	end
	
end
