class Elements
	def initialize(window,img)
	 @img = Gosu::Image.new(window, "imgs/gun.png", false)
	 @x = @y = 0.0
	 @window = window
	 @alive = true
	end
	
	def x
	 return @x
	end

	def y
	 return @y
	end
	
	def warp(x, y)
	 @x, @y = x, y
	end
		
	def showxy
	 print "x=["+@x.to_s+"] y=["+@y.to_s+"]\n"
	end

	def draw
	 if @alive == true
	  @img.draw_rot(@x, @y, 1, 0)
	 end
	end
	
end

class Gun < Elements

	def pickup(x,y,inv)
	 if @alive == true
	  if (x >= @x and x <= @x+20 and y >= @y and y <= @y+20)
	    if inv.get_id_by_name("gun") == NIL
	     inv.add("gun",10)
	    else
	     new_value = inv.get_opt(inv.get_id_by_name("gun"))+10
	     inv.update(inv.get_id_by_name("gun"),new_value)
	    end
	    @alive = false
	  end 
	 end
	end

end
