#Author : Erfan Hosseini

import utm
import glob
import os
import csv
import datetime
import math
from geopy.distance import geodesic

# UTM Blaesheim 32 U
# UTM Chicago 16 T
# UTM GPS7 17 S
utm_data = [32,'U']

#final output
savior = []
#iteration over the final output list
it = 0
#last timestamps if available
last_t = 0
#flag for checking whether we are at the first point of the trajectory or not (needed to calculate angle and speed)
flag = False
path = 'trips/*.txt' #pathname here
#reading files
files = glob.glob(path)
contains_timestamp = input("Do the files contain timestamps?(Y/N)")
if contains_timestamp == "Y" or contains_timestamp == "y":
	for name in files:
		with open(name, 'r') as f1:
			a = f1.readlines()
			for line in a:
				savior.append([os.path.basename(name)[:-4],str(datetime.datetime(2011,1,1,11,34,59)+datetime.timedelta(0,round(float(line.split()[2]))))+"+03", utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1])[0], utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1])[1]])
				#finding speed and angle
				if flag == True:
					speed = geodesic(utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1]),tuple(savior[it-1][2:4])).meters/(round(float(line.split()[2]))-last_t)
					#adding speed
					savior[it-1].append(speed) 
					#computing angle
					if (utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1])[1] - savior[it-1][3]) != 0:
						temp = (utm.to_latlon(round(float(line.split()[0])), round(float(line.split()[1])), utm_data[0], utm_data[1])[0] - savior[it-1][2])/(utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1])[1] - savior[it-1][3])
						if temp < -1 or temp > 1:
							if math.degrees(math.asin(temp%1))>=0:
								savior[it - 1].append(math.degrees(math.asin(temp%1)))
							else:
								savior[it - 1].append(360+ math.degrees(math.asin(temp % 1)))
						else:
							if math.degrees(math.asin(temp))>=0:
								savior[it- 1].append(math.degrees(math.asin(temp)))
							else:
								savior[it - 1].append(360 + math.degrees(math.asin(temp)))
					else:
						if utm.to_latlon(round(float(line.split()[0])), round(float(line.split()[1])), utm_data[0], utm_data[1])[0] - savior[it-1][2] > 0:
							savior[it - 1].append(90)
						else:
							savior[it - 1].append(180)

				it += 1
				flag = True
				last_t = round(float(line.split()[2]))
		savior[-1].append(savior[-2][4])
		savior[-1].append(savior[-2][5])
		flag = False
elif contains_timestamp == "N" or contains_timestamp == "n":
	for name in files:
		with open(name, 'r') as f2:
			i = 0
			a = f2.readlines()
			for line in a:
				savior.append([os.path.basename(name)[:-4],str(datetime.datetime(2011,1,1,11,34,59)+datetime.timedelta(0,i))+"+03", utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1])[0], utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1])[1]])
				#finding speed and angle
				if flag == True:
					speed = geodesic(utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1]),tuple(savior[it-1][2:4])).meters
					#adding speed
					savior[it-1].append(speed)
					#computing angle
					if (utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1])[1] - savior[it-1][3]) != 0:
						temp = (utm.to_latlon(round(float(line.split()[0])), round(float(line.split()[1])), utm_data[0], utm_data[1])[0] - savior[it-1][2])/(utm.to_latlon(round(float(line.split()[0])),round(float(line.split()[1])),utm_data[0],utm_data[1])[1] - savior[it-1][3])
						if temp < -1 or temp > 1:
							if math.degrees(math.asin(temp%1))>=0:
								savior[it - 1].append(math.degrees(math.asin(temp%1)))
							else:
								savior[it - 1].append(360+ math.degrees(math.asin(temp % 1)))
						else:
							if math.degrees(math.asin(temp))>=0:
								savior[it- 1].append(math.degrees(math.asin(temp)))
							else:
								savior[it - 1].append(360 + math.degrees(math.asin(temp)))
					else:
						if utm.to_latlon(round(float(line.split()[0])), round(float(line.split()[1])), utm_data[0], utm_data[1])[0] - savior[it-1][2] > 0:
							savior[it - 1].append(90)
						else:
							savior[it - 1].append(180)

				i += 1
				it += 1
				flag = True
		#adding the last point's speed and angle (Does not exist so same as the previous point)
		savior[-1].append(savior[-2][4])
		savior[-1].append(savior[-2][5])
		flag = False
else:
	print("invalid option!")

file = open('kharita_input.csv', 'w+', newline='')

#writing the data into the file
with file:
	write = csv.writer(file)
	write.writerows(savior)

