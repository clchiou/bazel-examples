#!/usr/bin/env python3

import os.path
import re
import sys


def main(argv):
    pattern = re.compile(r'#include "(.*?\.c)"')
    input_path = argv[1]
    paths = argv[2:]
    for path in paths:
        if not path.endswith('.c'):
            raise Exception('%r not ends with .c' % path)
    output_file = sys.stdout
    with open(input_path, 'r') as input_file:
        for line in input_file:
            match = pattern.fullmatch(line.strip())
            if match:
                name = match.group(1)
                file_path = None
                for file_path in paths:
                    if os.path.basename(file_path) == name:
                        break
                else:
                    raise Exception('Cannot find %r in %r' % (name, paths))
                output_file.write('# 1 "%s" 1\n' % os.path.basename(file_path))
                write_to(file_path, output_file)
            else:
                output_file.write(line)
    return 0


def write_to(from_path, to_file):
    with open(from_path, 'r') as from_file:
        to_file.write(from_file.read())


if __name__ == '__main__':
    sys.exit(main(sys.argv))
