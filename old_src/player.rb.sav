class Player
	def initialize(window)
	 @image = Gosu::Image.new(window, "imgs/pl.png", false)
	 @sht_img = Gosu::Image.new(window, "imgs/bullet.png", false) 
	 @sht_acc = @sht_x = @sht_y = @x = @y = @vel_y = @vel_x = @angle = 0.0
	 @direction = [0,0]
	 @score = 0
	 @step = 4.5
	 @vi_shoot = [0,0]
	 @blk = Array.new
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

	def draw
	 @image.draw_rot(@x, @y, 1, @angle)
	 @sht_img.draw_rot(@sht_x, @sht_y, 1, 0)
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
#Lineynaya algebra 
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

        def len(x) # Length of V
         result=Math.sqrt(x[0]*x[0]+x[1]*x[1])
         return result
        end
	
	def vroute(x,y,x1,y1) #Pointer V
         result=[x1-x,y1-y]
         return result
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
	 else
	  @sht_x = @sht_y = 1000
	 end
	 @sht_acc -= 1
	end

end
