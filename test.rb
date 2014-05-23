def norm(v)
    v1 = Array.new
    v1[0] = v[0]/len(v)
    v1[1] = v[1]/len(v)
    return v1
end

def len(v)
 res =Math.sqrt(v[0]*v[0]+v[1]*v[1])
 return res
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
	print "Angle V1 with V2 ="+v1_v2.to_s+"\n"
	print "Angle V1 with X ="+v1_x.to_s+"\n"
	print "Angle V1 with X ="+v2_x.to_s+"\n"
	if v1_x > v1_v2
	 res = false
	elsif v2_x > v1_v2
	 res = false
	end
	
	return res
end

direction = [0, -1]
x = [5,7]
bl = [10,1]

print crossblock(direction, x, bl)

