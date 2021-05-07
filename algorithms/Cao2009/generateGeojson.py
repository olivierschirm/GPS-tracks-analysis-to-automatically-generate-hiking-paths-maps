import os
import sys
import json

e = open('edges.json', 'r')
n = open('nodes.json', 'r')
edgesJson = json.load(e)
nodes = json.load(n)

vertices = {}
for node in nodes :
    vertices[node['id']] = (node['longitude'], node['latitude'])

temp = []
edges = []
for edge in edgesJson :
    temp.append(edge['in_node'])
    temp.append(edge['out_node'])
    edges.append([vertices[edge['in_node']], vertices[edge['out_node']]])

intersections = []
iss = [i for i in temp if temp.count(i) >= 3]
for i in iss :
    intersections.append(vertices[i])

intersections = list(dict.fromkeys(intersections))
alone = [ e for e in temp if temp.count(e) == 1]

segmentsFinal = []

for a in alone : 
    seg = [a]
    while a not in intersections :
        ee = [ e for e in edges if a in e ]
        v = []
        for e in ee :
            v.append(e[0])
            v.append(e[1])

        a = list(set(v) - set(seg))
        if len(a) == 0 : break
        a = a[0]
        seg.append(a)
        if a in alone : 
            segmentsFinal.append(seg)
            break
    

for i in intersections :
    for e in [e for e in edges if i in e] :
        a = i
        seg = [a]
        while len(seg) == 1 or a not in intersections :
            ee = [ e for e in edges if a in e ] if len(seg) > 1 else [e]
            v = []
            for e in ee :
                v.append(e[0])
                v.append(e[1])

            a = list(set(v) - set(seg))
            if len(a) == 0 : break
            a = a[0]
            seg.append(a)
            if a in alone : break
        segmentsFinal.append(seg)

torm = []
for seg in segmentsFinal :
    if seg in torm : continue
    seg = seg.copy()
    seg.reverse()
    if seg in segmentsFinal : torm.append(seg)

segmentsFinal = [ s for s in segmentsFinal if s not in torm]

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