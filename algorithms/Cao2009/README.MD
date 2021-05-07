# Cao 2009 re-implementation

<p class="note" style="color : orange; font-weight: bold; display: inline">Warning :</p> This is a re implementation working with data whose format we modified to make everything suitable for our evaluation environment. we cannot guarantee the effectiveness of our methods if they are taken out of their context.

### Reference and citation

Should you use the source code and/or data from this site, please cite also the following paper:

> L. Cao and J. Krumm.
> From gps traces to a routable road map.
> ACM GIS, pages 3–12, 2009.

> Downloaded here https://www.cs.uic.edu/bin/view/Bits/Software

### Prepare the data

**Input format** : ID,lat,lon,IDPreviousPoint,IDNextPoint

- For the first row IDPreviousPoint = _None_
- For the last row IDNextPoint = _None_

We created `converter.py` that helps to generate this format. You just have to edit the TODO part and create the segments list from the inputpath.

We provide the data for the datasets of our study : `Chicago`, `Blaesheim`, `GPS7`, `GPS8`, `GPS9`, `GPS10`, `GPS11`, `GPS12`

### Launch the clarification

Open `cao2009_clarify.py` and edit path information :

```python
16 : all_trips = TripLoader.get_all_trips("trips_Blaesheim")
```

Run the script :

```shell
C:/.../Cao2009> python2 cao2009_clarify.py
````

Stop after the number of round that you want by doing a `CTRL+C`

### Run the script

Open `cao2009_generate_graph.py` and edit the following :

```python
468 : trip_round = "Number of last round"
469 : trip_max = "Number of trips"
```

```powershell
C:/.../Cao2009> python2 cao2009_generate_graph.py
```

### Convert the results

Convert `cao_graph.db` into `edges.json` and `nodes.json` :

1. launch DB browser (sqlite)
2. Open a Database
3. Select `cao_graph.db`
4. File>Export>Table to json
5. Select both nodes and edges
6. Save

Convert `edges.json` and `nodes.json` into Geojson :

```powershell
C:/.../Cao2009> python3 generateGeojson.py
```
