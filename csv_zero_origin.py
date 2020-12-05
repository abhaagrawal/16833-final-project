import argparse as ap
import csv
import time
import copy

#Assumes CSV is a column vector
parser = ap.ArgumentParser(description = "Subtract first value from every other value.")
parser.add_argument('infile',action='store',type=str)
parser.add_argument('-o',action='store',type=str,required=False,default='out.csv')
parser.add_argument('--no_header',action='store_false')
args = parser.parse_args();
first_values = []
with open(args.infile, newline='') as infile:
	reader = csv.reader(infile)
	with open(args.o, 'w+', newline='',) as outfile:
		writer = csv.writer(outfile)

		# Skip header
		if args.no_header:
			writer.writerow(next(reader))
			print("Skipped header")

		is_first_line = True
		
		for line in reader:
			if is_first_line:
				print("update first_values")
				
				first_values = copy.deepcopy(line)
				is_first_line = False;

			for i in range(len(line)):
				line[i] = str(int(line[i]) - int(first_values[0]))
			writer.writerow(line)
