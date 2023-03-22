# Open the input file
input_file = open("rel_level_6.txt", "r")

# Open output file
file = open("clean_rel_level_6.txt", "w")

# Read the input file
input_file = input_file.readlines()

# Iterate and clean input 
for line in input_file:
    if line.startswith("d_"):
        line = line.split(";")
        line = line[5:]
        line = " ".join(line)
        file.write(line)
    else:
        file.write(line)

# Close the file
file.close()
        
