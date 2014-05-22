def readlvl(lvl)
 bloks = Array.new
 bloks[0] = Array.new
 bloks[1] = Array.new
 i=0
 j=0
 open(lvl).each {|f|
   while j<32
 	if f[j] == "x"
 	 bloks[0]<< 20*j
 	 bloks[1]<<20*(i-1)
 	end
 	j+=1
   end
 i+=1
 j=0
 }

 return bloks
end

