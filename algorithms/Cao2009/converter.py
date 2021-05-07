import sys

inputpath = sys.argv[1]

#TODO
#segments = []
#segment = [p1, p2, p3...]
#p1 = (v1, v2)
#v1 = (lat, lon)

i = 0
p = 1
for segment in segments :
    pp = 0
    resultfile = open(inputpath + "res/trip_" + str(i) + ".txt","a")
    for point in segment :
        if pp == 0 : first = None
        else : first = p - 1

        if pp == len(segment) - 1 : last = None
        else : last = p + 1
        
        resultfile.write(str(p) + ','  + str(point[1]) + ',' + str(point[0]) + ',6000000000,' + str(first) + ',' + str(last) + '\n')

        p = p + 1
        pp = pp + 1
    i = i + 1
  
