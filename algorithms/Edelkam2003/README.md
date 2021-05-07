# Edelkamp2003 re-implementation

<p class="note" style="color : orange; font-weight: bold; display: inline">Warning :</p> This is a re implementation working with data whose format we modified to make everything suitable for our evaluation environment. we cannot guarantee the effectiveness of our methods if they are taken out of their context.

### Reference and citation

Should you use the source code and/or data from this site, please cite also the following paper:

> S. Edelkamp and S. Schrodl.
> Route planning and map inference with global positioning traces.
> In R. Klein, H.-W. Six, and L. Wegner, editors, Computer Science in Perspective, volume 2598 of LNCS, pages 128–151. Springer, 2003.

> Downloaded here https://www.cs.uic.edu/bin/view/Bits/Software

### Prepare the data

**Input format** : ID,lat,lon,IDPreviousPoint,IDNextPoint

- For the first row IDPreviousPoint = _None_
- For the last row IDNextPoint = _None_

We created `converter.py` that helps to generate this format. You just have to edit the TODO part and create the segments list from the inputpath.

We provide the data for the datasets of our study : `Chicago`, `Blaesheim`, `GPS7`, `GPS8`, `GPS9`, `GPS10`, `GPS11`, `GPS12`

### Run the script

Open `edelkamp2003.py` and edit the path information :

```python
17 : all_trips = TripLoader.get_all_trips("trips_Blaesheim/")
```

Run the script :

```powershell
C:/.../Edelkamp2003> python2 edelkamp2003.py
```

### Convert the results

Convert `edelkamp_graph.db` into `edges.json` and `nodes.json` :

1. launch DB browser (sqlite)
2. Open a Database
3. Select `edelkamp_graph.db`
4. File>Export>Table to json
5. Select both nodes and edges
6. Save

Convert `edges.json` and `nodes.json` into Geojson :

```powershell
C:/.../Edelkamp2003> python3 generateGeojson.py
```
