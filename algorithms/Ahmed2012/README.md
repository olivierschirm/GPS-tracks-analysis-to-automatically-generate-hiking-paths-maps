# Ahmed 2012 re-implementation

<p class="note" style="color : orange; font-weight: bold; display: inline">Warning :</p> This is a re implementation working with data whose format we modified to make everything suitable for our evaluation environment. we cannot guarantee the effectiveness of our methods if they are taken out of their context.

### Reference and citation

Should you use the source code and/or data from this site, please cite also the following paper:

> Mahmuda Ahmed and Carola Wenk.
>Constructing Street Networks from GPS Trajectories
>European Symposium on Algorithms (ESA): 60-71, Ljubljana, Slovenia, 2012

> Downloaded from here : https://github.com/pfoser/mapconstruction

### Prepare the data

**Input format** : x y timestamp

- x and y has to be in UTM format.
- timestamp could be an i = i + 1 increment.

We created `convertergps.py` and `convertergpx.py` whose helps to generate this format. You just have to edit the the inputpath information at the beginning of each script and then launch the script. Make sure the _res/_ folder is created before running a script.

```shell
C:/.../Ahmed2012> python3 convertergpx.py

or

C:/.../Ahmed2012> python3 convertergps.py
```

### Run the script

Open `script_to_run.sh` and edit the following :

```shell
7 : INPUT_PATH=""
8 : OUTPUT_PATH=""
9 : EPS=
```

EPS is the epsilon parameter describe in the paper.

### Convert the results

Orignal results are on a vertcies.txt and edges.txt shape. To convert this in a geojson format please open `outputToGeojson.py` and edit the following by replacing the utm values for your zone :

```python
12 : coordinate = utm.to_latlon(float(line[1]), float(line[2]), 17, 'S')
```

- Blaesheim 32 U
- Chicago 16 T
- GPS7 17 S

Run the script :

```shell
C:/.../Ahmed2012> python3 outputToGeojson.py
```
