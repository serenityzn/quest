class Player < Human
	def inv
	 @inv = Inventory.new(@mw)
	 @inv.warp(20, 200)
	 @inv.draw
	end

	def turn_left
	 vel_x = vel_y = 0
	   @angle -= @step
	   vel_x += Gosu::offset_x(@angle, 0.1)
	   vel_y += Gosu::offset_y(@angle, 0.1)
	   @direction = [vel_x,  vel_y]
	end
	
	def turn_right
	 vel_x = vel_y = 0
	   @angle += @step
	   vel_x += Gosu::offset_x(@angle, 0.1)
	   vel_y += Gosu::offset_y(@angle, 0.1)
	   @direction = [vel_x,  vel_y]
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
	 @vel_x += Gosu::offset_x(@angle, 0.1)
	 @vel_y += Gosu::offset_y(@angle, 0.1)
	end

	def deaccelerate
	 @vel_x -= Gosu::offset_x(@angle, 0.1)
	 @vel_y -= Gosu::offset_y(@angle, 0.1)
	end

	def move
         if simple_check(@direction) == 0
	  @x += @vel_x
	  @y += @vel_y
	  @x %= 640
	  @y %= 480
         end
	  @vel_x *= 0.95
	  @vel_y *= 0.95
	end

	def showxy
#	 print "velx=["+@vel_x.to_s+"] vel_y=["+@vel_y.to_s+"]\n"
#	 print "x=["+@x.to_s+"] y=["+@y.to_s+"]\n"
#	 print "Direction Is: "+@direction.to_s+"\n\n"
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

#------------SHOOT
	def sht_start(ac)
	 v0_shoot = [@x, @y]
	 dir = v_norm(@direction)
	 range = 200
	 vn_max = [v0_shoot[0]+dir[0]*range, v0_shoot[1]+dir[1]*range]
	 vn_last =[vn_max[0]-v0_shoot[0], vn_max[1]-v0_shoot[1]]
	 @vi_shoot = [vn_last[0]/ac, vn_last[1]/ac]
	 @sht_x = @x
	 @sht_y = @y
	 @sht_acc = ac
	end

	def shoot
	 if @sht_acc > 0
	  @sht_x += @vi_shoot[0]
	  @sht_y += @vi_shoot[1]
	  @sht_acc -= 1
	 else
	  @sht_x = @sht_y = 1000
	 end
	end

end
