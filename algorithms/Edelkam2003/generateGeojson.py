import os
import sys
import json

e = open('edges.json', 'r')
n = open('nodes.json', 'r')
edges = json.load(e)
nodes = json.load(n)

vertices = {}
for node in nodes :
    vertices[node['id']] = (node['longitude'], node['latitude'])

temp = []
segments = []
for edge in edges :
    temp.append(edge['in_node'])
    temp.append(edge['out_node'])
    segments.append([vertices[edge['in_node']], vertices[edge['out_node']]])

intersections = []
iss = [i for i in temp if temp.count(i) >= 3]
for i in iss :
    intersections.append(vertices[i])

intersections = list(dict.fromkeys(intersections))

segmentsFinal = []
seg = []
for segment in segments :
    if len(seg) == 0 : 
        seg.append(segment[0])
        seg.append(segment[1])
        continue
    
    if segment[0] != seg[-1] or segment[0] in intersections:
        segmentsFinal.append(seg)
        seg = []
        seg.append(segment[0])
        seg.append(segment[1])
    else :
        seg.append(segment[1])


from geojson import Point, Feature, FeatureCollection, dump, LineString
features = []

for segment in segmentsFinal :
    lineString = LineString([cell for cell in segment])
    features.append(Feature(geometry=lineString, properties={'stroke' : 'green'}))

for intersection in intersections :
    features.append(Feature(geometry=Point(intersection), properties={'marker-color': '#3fc700'}))

feature_collection = FeatureCollection(features)

with open('result.geojson', 'w') as f:
    dump(feature_collection, f)