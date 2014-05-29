class Level
	def initialize(window, size)
	 @img_wall = Gosu::Image.new(window, "imgs/bl.png", false)
	 @img_door = Gosu::Image.new(window, "imgs/door.png", false)
	 @x = @y = 0
	 @bloks = Array.new
	 @bloks[0] = Array.new
	 @bloks[1] = Array.new
	 @bloks = readlvl('level.lvl')
	 @max = @bloks[1].size
	 @drs = Array.new
	 @drs[0] = Array.new
	 @drs[1] = Array.new
	 @drs_m = Array.new
	 @drs_m[0] = Array.new
	 @drs_m[1] = Array.new
	 @doors_array = Array.new
	 @n_door_coord = [0, 0, 0]
	end

	def size
	 return @max
	end

	def bloks
	 return @bloks
	end

	def warp
	 create_doors_array
	 @doors_array = door_create(@drs, get_uniq_y(@drs))
#	 print @doors_array.to_s+"\n"
	end

	def draw
	 i = 0
	 j=0
	 while i<@max
	  if @bloks[2][i] == "x"
	   @img_wall.draw_rot(@bloks[0][i]+10, @bloks[1][i]+10, 1, 0)
	  elsif @bloks[2][i] == "="
	   @img_door.draw_rot(@bloks[0][i]+10, @bloks[1][i]+10, 1, 0)
	   @drs[0][j] = @bloks[0][i] 
	   @drs[1][j] = @bloks[1][i] 
	   j += 1
	  end
	   i +=1
	 end
	end

	def create_doors_array
	  i = j = 0
	  while i<@max
	    if @bloks[2][i] == "="
	     @drs[0][j] = @bloks[0][i] 
	     @drs[1][j] = @bloks[1][i] 
	     j += 1
	    end
	   i += 1
	  end
	end

	def open_door
	  i = 0
	  com = 0
	  while i<@bloks[0].size
	  com = @n_door_coord[1]
	   while com <= @n_door_coord[2]
	    if @bloks[0][i] == com and @bloks[1][i] == @n_door_coord[0] and @bloks[2][i] == "="
		@bloks[2][i] = "+"
		@bloks[0][i] = -100
		@bloks[1][i] = -100
		@n_door_coord[3] = "Opened"
		change_door_arr(@n_door_coord)
	    end
	    com += 20
	   end
	   i += 1
	  end
	end

	def print_pl
	  i = 0
	  while i<@bloks[0].size
	    if @bloks[2][i] == "+"
	     print "BLOKS=["+@bloks[0][i].to_s+","+@bloks[1][i].to_s+"] OPT="+@bloks[2][i].to_s+"\n"
	    end
	    i += 1
	  end
	end

	def close_door
	  i =  com = 0
	  while i<@bloks[0].size
	    com = @n_door_coord[1]
	    while com <= @n_door_coord[2]
#	     print_pl
#	     print "Ndoor="+@n_door_coord.to_s+"\n"
	     print "enter\n"
		@bloks[2] << "="
		@bloks[0] << @n_door_coord[1][i]
		@bloks[1] << @n_door_coord[0][i]
	     com += 20
	    end
	    i += 1
	  end
	end

	def change_door_arr(val)
	  i = 0
	  while i<@doors_array.size
	    if @doors_array[0][i].to_i == val[0] and @doors_array[1][i].to_i == val[1] and @doors_array[2][i] == val[2]
		@doors_array[3][i] = val[3]
	    end
	    i += 1
	  end
	end

	def chk_near_door(x,y)
	 i = 0
	 res = Array.new
	 while i<@doors_array[0].size
	   if (y < @doors_array[0][i].to_i and y > @doors_array[0][i].to_i-25) or (y > @doors_array[0][i].to_i+20 and y < @doors_array[0][i].to_i+45)
		if x > @doors_array[1][i].to_i and x < @doors_array[2][i].to_i+20
		 res[0] = "DOOR"
		 res[1] = @doors_array[3][i]
		 #print "doors_array="+@doors_array.to_s+"\n"
		 @n_door_coord = [@doors_array[0][i].to_i,@doors_array[1][i].to_i,@doors_array[2][i].to_i, @doors_array[3][i]]
		else
		 res[0] = "" 
		 res[1] = ""
		end
	   end
	   i += 1
	 end
	 return res
	end
	
#===========Doors calculation
 def get_uniq_y(mas)
         arr = a_copy(mas[1])
         i = j = k = min = 0
         max = arr.size
         while i<max
           j = i+1
           while j < max
            if arr[i] == arr[j]
                min = j
                while min < max
                 arr[min] = arr[min+1]
                 min += 1
                end
                j -= 1
                max -= 1
            end
            j += 1
           end
          i += 1
         end
         return arr
        end

        def a_copy(mas)
         res = Array.new
         i = 0
         while i<mas.size
          res << mas[i]
          i += 1
         end
         return res
        end

        def get_max(arr)
         max = i = 1
         max = arr[0]
         while i< arr.size
                if max < arr[i]
                   max = arr[i]
                end
          i += 1
         end
         return max
        end

	def get_min(arr)
         min = i = 1
         min = arr[0]
         while i< arr.size
                if min > arr[i]
                   min = arr[i]
                end
          i += 1
         end
         return min
        end


        def door_create(mas, y_uniq)
          i = j = 0
          res = Array.new
          res[0] = Array.new # Y coord
          res[1] = Array.new # x min
          res[2] = Array.new # x max
          res[3] = Array.new # Open/Closed
          prom = Array.new
          while y_uniq[i] != NIL
             res[0][i] = y_uniq[i].to_s
             j = 0
             while j<mas[1].size
                if y_uniq[i] == mas[1][j]
                 prom<< mas[0][j]
                end
                j += 1
             end
             res[1][i] = get_min(prom)
             res[2][i] = get_max(prom)
             res[3][i] = "Closed"
             prom = []
           i += 1
          end
         return res
        end

# READ LEVEL
    def readlvl(lvl)
         bloks = Array.new
         bloks[0] = Array.new
         bloks[1] = Array.new
         bloks[2] = Array.new
         i=0
         j=0
         open(lvl).each {|f|
           while j<32
                if f[j] == "x" or f[j] == "="
                 bloks[0]<< 20*j
                 bloks[1]<< 20*(i-1)
                 if f[j] == "x"
                  bloks[2]<< "x"
                 elsif f[j] == "="
                  bloks[2]<< "="
                 end
                end
                j+=1
           end
         i+=1
         j=0
         }

         return bloks
        end

end	
