# Kharita2018 re-implementation

<p class="note" style="color : orange; font-weight: bold; display: inline">Warning :</p> This is a re implementation working with data whose format we modified to make everything suitable for our evaluation environment. we cannot guarantee the effectiveness of our methods if they are taken out of their context.

### Reference and citation

Should you use the source code and/or data from this site, please cite also the following paper:

> Stanojevic, Rade, Sofiane Abbar, Saravanan Thirumuruganathan, Sanjay Chawla, Fethi Filali, and Ahid Aleimat
> Robust road map inference through network alignment of trajectories.
> In Proceedings of the 2018 SIAM International Conference on Data Mining, pp. 135-143. Society for Industrial and Applied Mathematics, 2018. [[Arxiv version](https://arxiv.org/abs/1702.06025)]

> Downloaded here https://github.com/vipyoung/kharita

### Prepare the data
**Input format** : vehicule_id,timestamp,lat,lon,speed,angle

- Vehicule_id: important to identify trajectories.
- Timestamp: important to sort gps points within trajectories
- timestamp: in the format: yyyy-mm-dd hh:mm:ss+03
- angle: in 0-360 interval. Angle to the north.

In order to generate the require CSV inputs starting from GPX files please use our `gpxtoinputconverter.py`. You just have to do the following : 

Open `gpxtoinputconverter.py` and edit path information

```python
7 : inputpath = 'Path to GPX folder ending by "/"'
```

```shell
C:/.../Kharita2018> python3 gpxtoinputconverter.py
```

Once you got your txt files you can launch `inputconverter.py` comming from https://github.com/Erfanh1995/Kharita_inputconverter Open `inputconverter.py` and replace the following by your information :

```python
# UTM Blaesheim 32 U
# UTM Chicago 16 T
# UTM GPS7 17 S
14 : utm_data = [32,'U']
24 : path = 'trips/*.txt'
```

```shell
C:/.../Kharita2018> python3 inputconverter.py
```

### Running Kharita offline

Open `kharita.py` and replace the following by your information :

```python
23 : theta = 140
24 : SEEDRADIUS = 70
25 : datafile = 'trips_Blaesheim.csv'
```

Run the script :

```shell
C:/.../Kharita2018> python3 kharita.py
```

### Convert the results

```shell
C:/.../Kharita2018> python3 generateGeojson.py
```
