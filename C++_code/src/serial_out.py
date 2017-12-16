#!/usr/bin/env python3

import serial
import fileinput

open('./src/serial_out.txt', 'w').close()

ser = serial.Serial('/dev/ttyACM0', 57600)

while True:
	with open('./src/serial_out.txt', 'a') as file:
		file.write(ser.readline())


