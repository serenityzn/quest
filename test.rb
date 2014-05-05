#Vektor naprvl norm =[-0.830128450854529,-0.55757219719231]
#Vektor obzora norm =[-0.830128450854529,-0.55757219719231]
#Proizvedenie = 1.0

@x = 1
@y = 3
@direction = [1,1]

def vpr(x,y)
         res = x[0]*y[0]+x[1]*y[1]
         return res
        end   

def v_norm(v)
         len =  Math.hypot(v[0],v[1])
         norm = [v[0]/len, v[1]/len]
         return norm
        end


def check_fov1(x,y,angle)
         v = [x-@x, y-@y]
         dir = @direction
         vn = v_norm(v)
         dn = v_norm(dir)
#         print "BOT = ["+@x.to_s+","+@y.to_s+"]\n"
 #        print "PL = ["+x.to_s+","+y.to_s+"]\n"
  #       print "Vektor naprvl norm =["+vn[0].to_s+","+vn[1].to_s+"]\n"
   #      print "Vektor obzora norm =["+dn[0].to_s+","+dn[1].to_s+"]\n"
         pro = vpr(vn,dn)
         print "Proizvedenie = "+pro.to_s+"\n"
         bangle = (Math.acos(pro)*180)/3.14159
         print "angle="+bangle.to_s+"\n\n"
         if bangle > angle/2
          res =0
         else
          res =1
         end

         return res
        end

print check_fov1(3,2, 120)
