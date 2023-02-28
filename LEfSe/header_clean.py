test = open("rel_level_6.txt", "r")
file = open("clean_rel_level_6.txt", "w")

test = test.readlines()

for line in test:
    if line.startswith("d_"):
        line = line.split(";")
        #print(holder)
        line = line[5:]
        #print(line)
        line = " ".join(line)
        file.write(line)
    else:
        file.write(line)

#print(test)
file.close()
        
