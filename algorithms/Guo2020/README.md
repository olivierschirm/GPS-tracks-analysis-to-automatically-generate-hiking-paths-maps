# Guo2020 re-implementation

<p class="note" style="color : orange; font-weight: bold; display: inline">Warning :</p> This is a re implementation working with data whose format we modified to make everything suitable for our evaluation environment. we cannot guarantee the effectiveness of our methods if they are taken out of their context.

### Reference and citation

Should you use the source code and/or data from this site, please cite also the following paper:

> Guo, Y, Bardera, A, Fort, M, Silveira, R.I. 
> A scalable method to construct compact road networks from GPS trajectories.
> International Journal of Geographical Information Science. 2020.

> Downloaded here https://figshare.com/articles/software/A-scalable_method-to-construct-compact-road-networks-from-GPS-trajectories_zip/12199541

### Prepare the data

This matlab project is using a traj cell structure as input. You have 2 different option to load the data :

1) From original author .mat files (`Chicago`, `athens_large`, `athens_small`, `berlin_large`)

Replace the TODO part in `main.m` by :

```matlab
dataPath = 'data/chicago';
load(strcat(dataPath,'.mat'));
```

2) From our datasets (`Blaesheim`, `GPS7`, `GPS8`, `GPS9`, `GPS10`, `GPS11`, `GPS12`) and others.

Replace the TODO part in `main.m` by :

```matlab
dataPath = 'trips_Blaeshiem/';
traj = {};
files = dir(strcat(dataPath, '*.txt'));
for file = files'
    txt = load(strcat(dataPath, file.name));
    id = str2double(extractBetween(file.name, "trip_", ".txt"));
    traj{id + 1} = txt;
end
```
### Run the script

Make sure all files are in the Path and run `main.m` with matlab. You can also change the parameters here.

### Convert the results

Orignal results are on a vertices.txt and edges.txt shape. To convert this in a geojson format please open `outputToGeojson.py` and edit the following by replacing the utm values for your zone :

```python
12 : coordinate = utm.to_latlon(float(line[1]), float(line[2]), 17, 'S')
```

- Blaesheim 32 U
- Chicago 16 T
- GPS7 17 S

Run the script :

```shell
C:/.../Guo2020> python3 outputToGeojson.py
```