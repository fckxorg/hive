import sys

for line in sys.stdin:
    line = line.strip()
    number = int(line)
    print(100 - number)

