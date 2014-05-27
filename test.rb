class Test 
	def initialize
	 @x = 22
	end
end

class Test1 < Test
	def x
	 print @x
	end
end

a = Test1.new
print a.x
