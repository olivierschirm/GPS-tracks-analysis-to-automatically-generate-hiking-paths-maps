import numpy
import json
from math import *
import sys
import os

inputpath = "result/"
outputpath = "resultWithIntersection/"

for filename in os.listdir(inputpath) :
    segmentTruth = []
    with open(inputpath + filename) as groundTruthFile:
        for jsonSegment in json.load(groundTruthFile)['features'] :
            if jsonSegment['geometry']['type'] == "LineString" :
                segmentTruth.append(jsonSegment['geometry']['coordinates'])

    nodes = []
    for seg in segmentTruth :
        nodes.extend(seg)

    nodes = [(node[0], node[1]) for node in nodes if nodes.count(node) > 2]
    nodes = list(dict.fromkeys(nodes))

    from geojson import Point, Feature, FeatureCollection, dump, LineString
    features = []

    for segment in segmentTruth :
        lineString = LineString([cell for cell in segment])
        features.append(Feature(geometry=lineString, properties={"stroke" : "green"}))

    for intersection in nodes :
        features.append(Feature(geometry=Point((intersection)), properties={"marker-color": "#E0F90F"}))

    feature_collection = FeatureCollection(features)

    with open(outputpath + filename, 'a') as f:
        dump(feature_collection, f)