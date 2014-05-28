class Human
	def initialize(window,img,step)
	 @image = Gosu::Image.new(window, img[0], false)
	 @sht_img = Gosu::Image.new(window, img[1], false)
	 @sht_x = @sht_y = @sht_acc = @x = @y = @x0 = @y0 = @vel_y = @vel_x = @angle = 0.0
         @direction = [step,0]
	 @score = 0
	 @step = step
	 @vi_shoot = [0,0]
	 @blk = Array.new
	 @route = 1 # right = 1 left = 2 up = 3 down = 4
	 @mw = window
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

	def v_norm(v)
	 len =  Math.hypot(v[0],v[1])
	 norm = [v[0]/len, v[1]/len]
	 return norm
	end

	def norm(v)
	    v1 = Array.new
	    v1[0] = v[0]/len(v)
	    v1[1] = v[1]/len(v)
	    return v1
	end

	def skal(a,b)
	 res = a[0]*b[0]+a[1]*b[1]
	 return res
	end

	def crossblock(direction, x, bl)
	        res = false
	        bl1 = [0,0]
		bl2 = [0,0]
	        bl1[0] = bl[0]
	        bl1[1] = bl[1]+20
		bl2[0] = bl[0]+20
		bl2[1] = bl[1]
	        v1 = [bl[0]-x[0], bl[1]-x[1]]
	        v2 = [bl1[0]-x[0], bl1[1]-x[1]]
		v3 = [bl2[0]-x[0], bl2[1]-x[1]]
	        v1_v2 = (Math.acos(skal(norm(v1), norm(v2)))*180/3.14159)
	        v1_v3 = (Math.acos(skal(norm(v1), norm(v3)))*180/3.14159)
	        v1_x = (Math.acos(skal(norm(v1), norm(direction)))*180/3.14159)
	        v2_x = (Math.acos(skal(norm(v2), norm(direction)))*180/3.14159)
	        v3_x = (Math.acos(skal(norm(v3), norm(direction)))*180/3.14159)
	        if v1_x < v1_v2
	         res = true
	        elsif v2_x < v1_v2
	         res = true
		elsif v1_x < v1_v3
		 res = true
		elsif v3_x < v1_v3
		 res = true
	        end

	        return res
	end
	
	def vroute(x,y,x1,y1) #Pointer V
	 result=[x1-x,y1-y]
	 return result
	end

	def len(x) # Length of V
	 result=Math.sqrt(x[0]*x[0]+x[1]*x[1])
	 return result
	end

	def showxy(x,y)
	end

	def draw
	 @image.draw_rot(@x, @y, 1, @angle)
	 @sht_img.draw_rot(@sht_x, @sht_y, 1, 0)
	end
	
	def simple_check(v_n)
	 step = 12
	 i = 0
	 res = 0
	 x = [@x, @y]
	 while i < @blk[0].size
	  bl = [@blk[0][i], @blk[1][i]]
	  if crossblock(@direction, x, bl ) == true
	   if len(vroute(@x+@direction[0],@y+@direction[1],@blk[0][i],@blk[1][i])) < step
	 	res = 1
	   elsif len(vroute(@x+@direction[0],@y+@direction[1],@blk[0][i]+20,@blk[1][i])) < step
                res = 1
           elsif len(vroute(@x+@direction[0],@y+@direction[1],@blk[0][i],@blk[1][i]+20)) < step
                res = 1
           elsif len(vroute(@x+@direction[0],@y+@direction[1],@blk[0][i]+20,@blk[1][i]+20)) < step
                res = 1
	   end
          end
	  i+=1
	 end
	 return res
	end
	
end
