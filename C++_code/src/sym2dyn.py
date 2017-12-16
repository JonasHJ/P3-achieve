#!/usr/bin/env python3
import fileinput

with open('./src/sym.txt', 'r') as file :
    filedata = file.read()

# Replace the target string
filedata = filedata.replace('i1_33', 'I1(3,3)')

filedata = filedata.replace('i2_11', 'I2(1,1)')
filedata = filedata.replace('i2_12', 'I2(1,2)')
filedata = filedata.replace('i2_13', 'I2(1,3)')
filedata = filedata.replace('i2_21', 'I2(2,1)')
filedata = filedata.replace('i2_22', 'I2(2,2)')
filedata = filedata.replace('i2_23', 'I2(2,3)')
filedata = filedata.replace('i2_31', 'I2(3,1)')
filedata = filedata.replace('i2_32', 'I2(3,2)')
filedata = filedata.replace('i2_33', 'I2(3,3)')

filedata = filedata.replace('i3_11', 'I3(1,1)')
filedata = filedata.replace('i3_12', 'I3(1,2)')
filedata = filedata.replace('i3_13', 'I3(1,3)')
filedata = filedata.replace('i3_21', 'I3(2,1)')
filedata = filedata.replace('i3_22', 'I3(2,2)')
filedata = filedata.replace('i3_23', 'I3(2,3)')
filedata = filedata.replace('i3_31', 'I3(3,1)')
filedata = filedata.replace('i3_32', 'I3(3,2)')
filedata = filedata.replace('i3_33', 'I3(3,3)')


filedata = filedata.replace('th1', 'theta(1)')
filedata = filedata.replace('th2', 'theta(2)')
filedata = filedata.replace('th3', 'theta(3)')

filedata = filedata.replace('lc1x', 'lc1(1)')
filedata = filedata.replace('lc1y', 'lc1(2)')
filedata = filedata.replace('lc1z', 'lc1(3)')
filedata = filedata.replace('lc2x', 'lc2(1)')
filedata = filedata.replace('lc2y', 'lc2(2)')
filedata = filedata.replace('lc2z', 'lc2(3)')
filedata = filedata.replace('lc3x', 'lc3(1)')
filedata = filedata.replace('lc3y', 'lc3(2)')
filedata = filedata.replace('lc3z', 'lc3(3)')


# Write the file out again
with open('./src/sym_update.txt', 'w') as file:
    file.write(filedata)
