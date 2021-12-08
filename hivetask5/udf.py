import sys

for line in sys.stdin:
    line = line.strip()
    tokens = line.split()
    tokens = tokens[:5] + [tokens[-1]]

    if 'Safari' in tokens[4]:
        tokens[4] = tokens[4].replace('Safari', 'Chrome')
    tokens = tokens[:1] + tokens[-1:] + tokens[1:-1]
    print('\t'.join(tokens))
