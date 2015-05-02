#!/bin/bash

set -o xtrace
rm -rf $(grep -v bazel .gitignore)
