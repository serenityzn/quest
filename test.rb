@a = Array.new
@a[0] = [0,20,40,60,100,120,40,60,80]
@a[1] = [10,10,10,10,20,20,50,50,50]

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
	     print "PROM="+prom.to_s+"\n"
	     res[1][i] = get_min(prom)
	     res[2][i] = get_max(prom)
	     print "MIN="+get_min(prom).to_s+"\n"
	     print "MAX="+get_max(prom).to_s+"\n"
	     prom = []
	   i += 1
	  end
	 return res
	end

