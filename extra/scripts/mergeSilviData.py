#!/usr/bin/env python

from sys import argv, exit

if len(argv) != 4:
	print("Usage: python mergeSilviData.py inputA.txt inputC.txt output.txt")
	exit(-1)

with open(argv[3], "w") as fout:
	with open(argv[1]) as fin:
		for line in fin:
			fields = line.strip().split('\t')
			fout.write("{}\tA\t{}\n".format(fields[0], fields[-1]))

	with open(argv[2]) as fin:
		for line in fin:
			fields = line.strip().split('\t')
			fout.write("{}\tC\t{}\n".format(fields[0], fields[-1]))



