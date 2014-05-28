class Bot < Human
	def accelerate
	 @vel_x += Gosu::offset_x(@angle, 0.5)
	 @vel_y += Gosu::offset_y(@angle, 0.5)
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
	  @angle = ang
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
	   @eangle = @angle+@bangle
	   @angle %= 360
	 else
	   see = 0
	 end
	 return see
	end
end
