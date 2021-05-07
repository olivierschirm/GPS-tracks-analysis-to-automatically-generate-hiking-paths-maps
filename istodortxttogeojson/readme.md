# Istodor txt to .geojson converter

This protocol aims at convert the given output to our geojson evaluating format. Initial data have been taken from here : http://cs.uef.fi/mopsi/routes/network/

### Do the conversion

Put the txt in data/ folder and run `istodortxttogeojson.py`

```powershell
C:/../istodortxttogeojson> python3 istodortxttogeojson.py
```

Results will be in the respective result/ folder. Now you just have to find the intersections to be coherent with our evaluator :

```powershell
C:/../istodortxttogeojson> python3 intersecfinder.py
```

Results will be in the respective resultWithIntersection/ folder.
