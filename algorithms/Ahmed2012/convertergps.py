import gpxpy
import gpxpy.gpx
import os
import utm

inputPath = ""
r = 0
for root, dirs, files in os.walk("inputPath"):
    for file in files:
        filetxt = open(inputPath + "/" + file, 'r')
        txt = open('res/trip_' + str(r) + '.txt', 'a')
        i = 0

        lines = filetxt.readlines()

        for line in lines :
            line = line.split(',')
            pt = utm.from_latlon(float(line[1]), float(line[2]))
            txt.write(str(pt[0]) + ' ' + str(pt[1]) + ' ' + line[0] + '\n')
                  
        r = r + 1