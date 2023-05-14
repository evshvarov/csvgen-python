import csv

file_prefix='/home/irisowner/dev'
# Open the input file and output file
with open(file_prefix+'/data/Installs Monthly.csv', 'r') as infile, open(file_prefix+'/data/output_file.csv', 'w', newline='') as outfile:

    # Create a CSV reader and writer
    reader = csv.reader(infile, delimiter='|')
    writer = csv.writer(outfile, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)

    # Write rows from the input file to the output file
    for row in reader:
        writer.writerow(row)