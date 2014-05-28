class Inventory
	def initialize(window)
	 @image = Array.new
	 @image[0] = Array.new # image
	 @image[1] = Array.new # desc
	 @image[2] = Array.new # optinons (ammo, number, etc)
	 @ramka = Gosu::Image.new(window, "imgs/ramka.png", false)
	 #@image << Gosu::Image.new(window, "imgs/card.png", false)
	 @size = 6
	 @n_el = 0
	 @x = @y = 0.0
	 @blk = Array.new
	 @window = window
	 @font = Gosu::Font.new(window, Gosu::default_font_name, 20)
	end
	
	def add(element,opt)
	 @image[0] << Gosu::Image.new(@window, "imgs/"+element+".png", false)
	 @image[1] << element
	 @image[2] << opt
	end

	def update(id,new)
	 @image[2][id] = new
	end
	
	def get_opt(id)
	 return @image[2][id]
	end

	def get_id_by_name(name) #return inventory id by name
	  return @image[1].index(name)
	end

	def x
	 return @x
	end

	def y
	 return @y
	end
	
	def next
	 if @n_el < @image[0].size-1
	  @n_el += 1
	 else
	  @n_el = 0
	 end
	end

	def prev
	 if @n_el > 0
	  @n_el -= 1
	 else
	  @n_el = @image[0].size-1
	 end
	end
	
	def warp(x, y)
	 @x, @y = x, y
	 add("card",1)
	 add("gun", 10)
	 add("key", 1)
	end
		
	def get_name(n)
	 return @image[1][n]
	end
	
	def get_num
	 return @n_el
	end

	def showxy
#	 print "x=["+@x.to_s+"] y=["+@y.to_s+"] Direction = ["+@direction[0].to_s+","+@direction[1].to_s+"]\n"
	end

	def draw
          i=0
	 while i<@image[0].size
	  @image[0][i].draw_rot(@x+i*40, @y, 1, 0)
	  i += 1
	 end
	 @ramka.draw_rot(@x+@n_el*40,@y,1,0)
	 return @n_el
	end
	
end
