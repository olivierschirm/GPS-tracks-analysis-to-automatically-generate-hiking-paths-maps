import gpxpy
import gpxpy.gpx
import os
import utm
from datetime import timedelta, datetime

inputpath = 'Path to GPX folder ending by "/"'

for root, dirs, files in os.walk(inputpath):
    i = 0
    for file in files:
        gpx_file = open(inputpath + file, 'r')
        gpx = gpxpy.parse(gpx_file)
        resultfile = open(str(i) + ".txt","a")

        p = 0
        for track in gpx.tracks:
            for segment in track.segments:
                for point in segment.points :
                    if p == 0 : date = point.time
                    delta = point.time - date
                    conv = utm.from_latlon(point.latitude, point.longitude)
                    resultfile.write(str(conv[0]) + ' ' + str(conv[1]) + ' ' + str(delta.total_seconds()) + '\n')
                    p = p + 1
        i = i + 1