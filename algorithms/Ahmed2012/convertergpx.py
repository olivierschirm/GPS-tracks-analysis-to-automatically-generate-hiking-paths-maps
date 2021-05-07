import gpxpy
import gpxpy.gpx
import os
import utm

inputPath = ""

r = 0
for root, dirs, files in os.walk(inputPath):
    for file in files:
        gpx_file = open(inputPath + "/" + file, 'r')
        gpx = gpxpy.parse(gpx_file)
        txt = open('res/trip_' + str(r) + '.txt', 'a')
        i = 0

        for track in gpx.tracks:
            for segment in track.segments:
                for point in segment.points :
                    i = i + 1
                    pt = utm.from_latlon(point.latitude, point.longitude)
                    string = str(pt[0]) + ' '  + str(pt[1]) + ' '  + str(i) + "\n"
                    txt.write(string)
                    
        r = r + 1