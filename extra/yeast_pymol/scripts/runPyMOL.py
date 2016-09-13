#!/usr/bin/env python

from sys import argv, exit

import pymol
from pymol import cmd, stored
pymol.pymol_argv = ['pymol', '-qc']
pymol.finish_launching()

if len(argv) != 1:
	print("Usage: python runPyMOL.py")
	exit(-1)

# Set parameters
cmd.set('dot_solvent', 1)
cmd.set('dot_density', 3)
cmd.set('solvent_radius', 3.0)

# Load pdbs
cmd.load("3u5b.pdb")
cmd.load("3u5c.pdb")
cmd.load("3u5d.pdb")
cmd.load("3u5e.pdb")

# Create ribosome complex
cmd.create("mycomp", "3u5b 3u5c 3u5d 3u5e")

with open("yeast_18S.sasa", "w") as fout18S, open("yeast_25S.sasa", "w") as fout25S:
	# First deal with A (N1)
	stored.residues = []
	cmd.iterate("mycomp///A/N1", "stored.residues.append((int(chain), int(resi)))")
	stored.residues.sort()

	# 18S
	alist = [y for (x, y) in stored.residues if x == 2]
	for i in alist:
		outstr = "{0}\tA\t{1:.4f}\n".format(i, cmd.get_area("/mycomp//2/{0}/N1".format(i)))
		fout18S.write(outstr)

	# 25S
	alist = [y for (x, y) in stored.residues if x == 1]
	for i in alist:
		outstr = "{0}\tA\t{1:.4f}\n".format(i, cmd.get_area("/mycomp//1/{0}/N1".format(i)))
		fout25S.write(outstr)

	# Now deal with C (N3)
	stored.residues = []
	cmd.iterate("mycomp///C/N3", "stored.residues.append((int(chain), int(resi)))")
	stored.residues.sort()

	# 18S
	clist = [y for (x, y) in stored.residues if x == 2]
	for i in clist:
		outstr = "{0}\tC\t{1:.4f}\n".format(i, cmd.get_area("/mycomp//2/{0}/N3".format(i)))
		fout18S.write(outstr)

	# 25S
	clist = [y for (x, y) in stored.residues if x == 1]
	for i in clist:
		outstr = "{0}\tC\t{1:.4f}\n".format(i, cmd.get_area("/mycomp//1/{0}/N3".format(i)))
		fout25S.write(outstr)
