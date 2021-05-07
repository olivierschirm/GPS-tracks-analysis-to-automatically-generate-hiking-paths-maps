import os

inputpath = "data"

for filename in os.listdir(inputpath) :
    traces = [[]]
    new = True
    with open((inputpath + '/' + filename)) as traceFile:
        data = traceFile.readlines()
        for d in data :
            if d != '\n' : 
                temp =  d[:-2].split(" ")
                point = ((float(temp[1]), float(temp[0])))
            else : point = False
            
            if point == traces[-1] : new = False
            elif point and point != traces[-1] : new = True

            if not point and new : traces.append([])
            if point and new :
                traces[-1].append(point)
    
        points = []
        for trace in traces :
            for point in trace :
                points.append(point)
  

    from geojson import Point, Feature, FeatureCollection, dump, LineString
    features = []

    for segment in traces :
        lineString = LineString([cell for cell in segment])
        features.append(Feature(geometry=lineString, properties={'stroke' : 'green'}))

    feature_collection = FeatureCollection(features)

    with open('result\\%s.geojson' % (filename.split('.')[0]), 'w') as f:
        dump(feature_collection, f)