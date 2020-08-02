import numpy as np
import random
from PIL import Image

xmax = 300
ymax = 80000
pitmin = 1
pitmax = 3
depthscale = 0.1
roadfill = 50

def create_pit(array, dip, xloc, yloc):
    for t in range(dip):
        for i in range(xloc-t,xloc+t+1):
            for j in range(yloc-t,yloc+t+1):
                if(i>=0 and j>=0 and i<xmax and j<ymax):
                    if(array[i][j]>(roadfill-(pitmax-pitmin)*depthscale)):
                        array[i][j]=array[i][j]-depthscale
                        # array[i][j]=0
    

array = np.empty([xmax, ymax]) 
array.fill(roadfill)

for i in range(10000):
    dip = random.randint(pitmin, pitmax)
    xloc = random.randint(0, xmax-1)
    yloc = random.randint(0, ymax-1)
    create_pit(array, dip, xloc, yloc)

# for i in range(10000):
#     dip = random.randint(pitmin, pitmax)
#     xloc = random.randint(0, xmax-1)
#     yloc = random.randint(0, ymax-1)
#     array[xloc][yloc]=roadfill-1

array = array.T

img = Image.fromarray(array)
if img.mode != 'RGB':
    img = img.convert('RGB')
img.save('test.png')