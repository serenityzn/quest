class Bot
	def initialize(window)
	 @image = Gosu::Image.new(window, "imgs/bot.png", false)
	 @x = @y = @vel_y = @vel_x = @angle = 0.0
	 @score = 0
	 @step = 1
	 @blk = Array.new
	 @route = 1 # right = 1 left = 2 up = 3 down = 4
	 @direction = [@step,0]

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
	 if check_fov1(x,y,90) == 1
	  @direction=chg_dir(x,y)
	 end
		if check(@direction[0],0) == 0
		 @x += @direction[0]
		 @y += @direction[1]
		else
		 @direction[0] = -1*@direction[0]
		end
	end

	def showxy(x,y)
#	 print "x=["+@x.to_s+"] y=["+@y.to_s+"]\n"
#	 print "PlayerCoord=["+x.to_s+","+y.to_s+"]\n"
#	 print "BotCoord=["+@x.to_s+","+@y.to_s+"]\n"
#	 print "BotDirection=["+@direction[0].to_s+","+@direction[1].to_s+"\n"
#	 print "DIR RESULT == [ "+check_fov(x, y).to_s+"]\n"
	end

	def draw
	 @image.draw_rot(@x, @y, 1, 0)
	end
	
	def vpr(x,y)
	 res = x[0]*y[0]+x[1]*y[1]
	 return res
	end

	def check_fov1(x,y,angle)
	 v = [x-@x, y-@y]
	 dir = @direction
	 vn = v_norm(v)
	 dn = v_norm(dir)
	 print "BOT = ["+@x.to_s+","+@y.to_s+"]\n"
	 print "PL = ["+x.to_s+","+y.to_s+"]\n"
	 print "Direction = ["+@direction[0].to_s+","+@direction[1].to_s+"]\n"
	 print "Vektor naprvl norm =["+vn[0].to_s+","+vn[1].to_s+"]\n"
	 print "Vektor obzora norm =["+dn[0].to_s+","+dn[1].to_s+"]\n"
	 pro = vpr(vn,dn)
	 print "Proizvedenie = "+pro.to_s+"\n"
	 if pro>1 
	  pro=1 
	 end
	 if pro<-1 
	  pro=-1 
	 end

	 bangle = Math.acos(pro)*180/3.14159
	 print "angle="+bangle.to_s+"\n\n"
	 if bangle > angle/2
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
	 else
	   see = 0
	 end
	 return see
	end
	
	def check(route, vert)
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
