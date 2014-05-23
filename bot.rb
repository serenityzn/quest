class Bot
	def initialize(window)
	 @image = Gosu::Image.new(window, "imgs/bot1.png", false)
	 @x = @y = @x0 = @y0 = @vel_y = @vel_x = @angle = 0.0
	 @score = 0
	 @step = 1
	 @blk = Array.new
	 @route = 1 # right = 1 left = 2 up = 3 down = 4
	 @direction = [@step,0]
	 @moveangle = 0

	end

	def warp(x, y, blk)
	 @x, @y = x, y
	 @blk = blk
	end

	def accelerate
	 @vel_x += Gosu::offset_x(@angle, 0.5)
	 @vel_y += Gosu::offset_y(@angle, 0.5)
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
	        res = true
	        bl1 =[0,0]
	        bl1[0] = bl[0]
	        bl1[1] = bl[1]+20
	        print bl.to_s+"\n"
	        print bl1.to_s+"\n"
	        v1 = [bl[0]-x[0], bl[1]-x[1]]
	        v2 = [bl1[0]-x[0], bl1[1]-x[1]]
	        v1_v2 = (Math.acos(skal(norm(v1), norm(v2)))*180/3.14159)
	        v1_x = (Math.acos(skal(norm(v1), norm(direction)))*180/3.14159)
	        v2_x = (Math.acos(skal(norm(v2), norm(direction)))*180/3.14159)
	#        print "Angle V1 with V2 ="+v1_v2.to_s+"\n"
	 #       print "Angle V1 with X ="+v1_x.to_s+"\n"
	  #      print "Angle V1 with X ="+v2_x.to_s+"\n"
	        if v1_x > v1_v2
	         res = false
	        elsif v2_x > v1_v2
	         res = false
	        end

	        return res
	end
	
	def chg_dir(x,y)
	 v = [x-@x, y-@y]
	 return v_norm(v)
	end

	def move(x,y)
	 walk(x,y)
	 @x %= 640
	 @y %= 480
	end
	
	def walk(x,y)
	  if @direction[1]<0
	    ang = get_angle2(@direction,-1,0)+180
	  else
	    ang = get_angle2(@direction,1,0)
	  end
	  @moveangle = ang
	 if (check_fov1(x,y,120) == 1 and block_fov(x,y) == 1)
	  @direction=chg_dir(x,y)
	 end
		if simple_check(@direction) == 0
		 @x0 = @x
		 @y0 = @y
		 @x += @direction[0]
		 @y += @direction[1]
		else
#		 @direction[0] = -1*@direction[0]
		 @direction = chg_dir(@x0, @y0)
		 @x = @x0
		 @y = @y0
		end
	end
	
	def vroute(x,y,x1,y1) #Pointer V
	 result=[x1-x,y1-y]
	 return result
	end

	def len(x) # Length of V
	 result=Math.sqrt(x[0]*x[0]+x[1]*x[1])
	 return result
	end

	def block_fov(x,y)
	 ii=0
	 result=1
                while ii<@blk[0].size
		 l1=len(vroute(@x,@y,x,y))	
		 l2=len(vroute(@x,@y,@blk[0][ii],@blk[1][ii]))
		 if (check_fov1(@blk[0][ii],@blk[1][ii],120) == 1 and l1>l2)
			result=0
		 end
                 ii+=1
                end
	 return result
	end

	def showxy(x,y)
	end

	def draw
	 @image.draw_rot(@x, @y, 1, @moveangle)
	end
	
	def vpr(x,y)
	 res = x[0]*y[0]+x[1]*y[1]
	 return res
	end

	def get_angle2(dir,xx, yy)
	 v = [xx,yy]
	 vn = v_norm(v)
	 dn = v_norm(dir)
	 pro = vpr(vn,dn)
         if pro>1
          pro=1
         end
         if pro<-1
          pro=-1
         end

         return angle = Math.acos(pro)*180/3.14159
	end

	def get_angle(x,y,bx,by,dir)
	 v = [x-bx, y-by]
         vn = v_norm(v)
         dn = v_norm(dir)
         pro = vpr(vn,dn)
         if pro>1
          pro=1
         end
         if pro<-1
          pro=-1
         end

         return angle = Math.acos(pro)*180/3.14159
	end
	
	def check_fov1(x,y,angle)
	 @bangle = get_angle(x,y,@x,@y,@direction)
	 if @bangle > angle/2
	  res =0
	 else
	  res =1
	 end

	 return res
	end

	def check_fov(plx, ply)
	 dtopl = [plx-@x, ply-@y]
	 res = dtopl[0]*@direction[0]+dtopl[1]*@direction[1]
	 if res > 0
	   see = 1
	   @moveangle = @moveangle+@bangle
	   @moveangle %= 360
	 else
	   see = 0
	 end
	 return see
	end

	def simple_check(v_n)
	 step = 20
	 i = 0
	 res = 0
	 x = [@x, @y]
	 while i < @blk[0].size
	  bl = [@blk[0][i], @blk[1][i]]
	  if crossblock(@direction, x, bl ) == true
	   if len(vroute(@x+@direction[0],@y+@direction[1],@blk[0][i],@blk[1][i])) < step
	 	res = 1
	   end
          end
	  i+=1
	 end
	 return res
	end
	
end
