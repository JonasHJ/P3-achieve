#!/usr/bin/env python3
import fileinput

with open('./src/dyn.txt', 'r') as file :
    filedata = file.read()

# Replace the target string
filedata = filedata.replace('i1_33', 'I1[i_33]')

filedata = filedata.replace('i2_11', 'I2[i_11]')
filedata = filedata.replace('i2_12', 'I2[i_12]')
filedata = filedata.replace('i2_13', 'I2[i_13]')
filedata = filedata.replace('i2_21', 'I2[i_21]')
filedata = filedata.replace('i2_22', 'I2[i_22]')
filedata = filedata.replace('i2_23', 'I2[i_23]')
filedata = filedata.replace('i2_31', 'I2[i_31]')
filedata = filedata.replace('i2_32', 'I2[i_32]')
filedata = filedata.replace('i2_33', 'I2[i_33]')

filedata = filedata.replace('i3_11', 'I3[i_11]')
filedata = filedata.replace('i3_12', 'I3[i_12]')
filedata = filedata.replace('i3_13', 'I3[i_13]')
filedata = filedata.replace('i3_21', 'I3[i_21]')
filedata = filedata.replace('i3_22', 'I3[i_22]')
filedata = filedata.replace('i3_23', 'I3[i_23]')
filedata = filedata.replace('i3_31', 'I3[i_31]')
filedata = filedata.replace('i3_32', 'I3[i_32]')
filedata = filedata.replace('i3_33', 'I3[i_33]')


filedata = filedata.replace('th1', 'theta[0]')
filedata = filedata.replace('th2', 'theta[1]')
filedata = filedata.replace('th3', 'theta[2]')

filedata = filedata.replace('l1', 'l[0]')
filedata = filedata.replace('l2', 'l[1]')
filedata = filedata.replace('l3', 'l[2]')
filedata = filedata.replace('lc1', 'lc[0]')
filedata = filedata.replace('lc2', 'lc[1]')
filedata = filedata.replace('lc3', 'lc[2]')

filedata = filedata.replace('l[0]^2', 'pow(l[0],2)')
filedata = filedata.replace('l[1]^2', 'pow(l[1],2)')
filedata = filedata.replace('l[2]^2', 'pow(l[2],2)')
filedata = filedata.replace('lc[0]^2', 'pow(lc[0],2)')
filedata = filedata.replace('lc[1]^2', 'pow(lc[1],2)')
filedata = filedata.replace('lc[2]^2', 'pow(lc[2],2)')

filedata = filedata.replace('m1', 'm[0]')
filedata = filedata.replace('m2', 'm[1]')
filedata = filedata.replace('m3', 'm[2]')

# Write the file out again
with open('./src/dyn_cpp.txt', 'w') as file:
    file.write(filedata)
