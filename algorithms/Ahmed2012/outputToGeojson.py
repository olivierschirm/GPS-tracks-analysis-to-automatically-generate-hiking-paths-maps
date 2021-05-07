import utm

verticesFile = open("resvertices.txt", 'r')
verticesLines = verticesFile.readlines()
vertices = []

for line in verticesLines :
    line = line.split(',')
    # UTM Blaesheim 32 U
    # UTM Chicago 16 T
    # UTM GPS7 17 S
    coordinate = utm.to_latlon(float(line[1]), float(line[2]), 17, 'S')
    vertices.append((coordinate[1], coordinate[0]))

edgesFile = open("resedges.txt", 'r')
edgesLines = edgesFile.readlines()
edges = []
temp = []

for line in edgesLines :
    line = line.split(',')
    v1 = int(line[1])
    v2 = int(line[2].replace('\n', ''))
    edge = (v1, v2)

    if len([ e for e in edges if v1 in e and v2 in e ]) == 0 :
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
    lineString = LineString([vertices[cell] for cell in segment])
    features.append(Feature(geometry=lineString, properties={'stroke' : 'green'}))

for intersection in intersections :
    features.append(Feature(geometry=Point(vertices[intersection]), properties={'marker-color': '#3fc700'}))

feature_collection = FeatureCollection(features)

with open('result.geojson', 'w') as f:
    dump(feature_collection, f)