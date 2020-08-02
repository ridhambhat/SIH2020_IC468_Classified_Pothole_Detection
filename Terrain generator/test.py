import numpy as np
array = np.empty([20, 20]) 
array.fill(10)
xloc = 4
yloc = 5
dip = 4
for t in range(dip):
    for i in range(xloc-t,xloc+t+1):
        for j in range(yloc-t,yloc+t+1):
            if(i>=0 and j>=0):
                array[i][j]=array[i][j]-1;
print(array)