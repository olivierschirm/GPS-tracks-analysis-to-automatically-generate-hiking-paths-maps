# Results

Here is all the results for the differents datasets we analyse on our paper. For each result two files are available :
- `algorithm_dataset.txt`
- `algorithm_dataset.geojson`

**Txt files** are composed that way :

```txt
###Intersection evaluation###    parameters
Acceptation Distance 10 m
Precision in %
Recall in %
FScore in %
Accuracy in m

...
Acceptation Distance 20m
Acceptation Distance 30m
Acceptation Distance 40m
...

###Intersection evaluation###
Acceptation Distance 50 m
Precision in %
Recall in %
FScore in %
Accuracy in m

==============================
###Segment evalution###
Precision in %
Recall in %
FScore in %
Accuracy in m
Standard deviation in m
Correctness in %
```

**Geojson files** regroups the geometry. Segments are LineString elements and intersections are Point element. You can open and visualize geojson with : http://geojson.io/#map=2/20.0/0.0
