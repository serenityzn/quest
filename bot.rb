class Bot
	def initialize(window)
	 @image = Gosu::Image.new(window, "imgs/bot1.png", false)
	 @x = @y = @vel_y = @vel_x = @angle = 0.0
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
		if simple_check == 0
		 @x += @direction[0]
		 @y += @direction[1]
		else
		 @direction[0] = -1*@direction[0]
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
#	 print "Direction=["+@direction[0].to_s+","+@direction[1].to_s+"]\n"
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

	def simple_check
	 i = 0
	 res = 0
	 while i < @blk[0].size
	  if len(vroute(@x+@direction[0],@y+@direction[1],@blk[0][i],@blk[1][i])) < 40
		res = 1
	  end
	  i+=1
	 end
	 return res
	end
	
end
