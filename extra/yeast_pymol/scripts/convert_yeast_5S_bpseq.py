#!/usr/bin/env python

from sys import argv, exit

if len(argv) != 3:
	print("Usage: python convert_yeast_5S_bpseq.py input.bpseq output.bpseq")
	exit(-1)

insertDict = {51 : 'A', 63 : 'A', 95 : 'G'}

with open(argv[1]) as fin, open(argv[2], "w") as fout:
	for i in range(4):
		line = next(fin)
		fout.write(line)

	pos = 1
	for line in fin:
		fields = line.strip().split()
		fields[0] = str(pos)
		fout.write(" ".join(fields) + "\n")
		pos += 1

		if pos in insertDict:
			fout.write("{0} {1} 0\n".format(pos, insertDict[pos]))
			pos += 1

