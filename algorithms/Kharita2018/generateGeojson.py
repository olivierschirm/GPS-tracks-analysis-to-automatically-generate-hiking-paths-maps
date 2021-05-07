import utm

edgesFile = open("edgesuic.txt", 'r')
edgesLines = edgesFile.readlines()
edges = []
temp = []

for line in edgesLines :
    line = line.split(' ')
    v1 = (float(line[0]) , float(line[1]))
    v2 = (float(line[3]) , float(line[4]))
    edge = [v1, v2]

    if len([ e for e in edges if e == [v2, v1] ]) == 0 :
        edges.append(edge)
        temp.append(edge[0])
        temp.append(edge[1])

intersections = []
iss = [i for i in temp if temp.count(i) >= 3]
for i in iss :
    intersections.append(i)

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

        a = list(set(v) - set(seg))[0]
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