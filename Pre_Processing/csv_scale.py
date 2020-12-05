import argparse as ap
import csv

parser = ap.ArgumentParser(description = "Multiply every value in a .csv by a constant")
parser.add_argument('infile',action='store',type=str)
parser.add_argument('scale',action='store',type=int)
parser.add_argument('-o',action='store',type=str,required=False,default='out.csv')
parser.add_argument('--no_header',action='store_false')
parser.add_argument('--div',action='store_true')
args = parser.parse_args();

with open(args.infile, newline='') as infile:
	reader = csv.reader(infile)
	with open(args.o, 'w+', newline='',) as outfile:
		writer = csv.writer(outfile)

		# Skip header
		if args.no_header:
			writer.writerow(next(reader))
			print("Skipped header")

		for line in reader:
			for i in range(0,len(line)):
				if args.div:
					line[i] = str(float(line[i]) / args.scale)
				else:
					line[i] = str(float(line[i]) * args.scale)
			writer.writerow(line)