#!/bin/bash

snakemake --snakefile Snakefile.py --cores 20 --dag -np | dot -Tsvg > dag.svg
snakemake --snakefile Snakefile.py --cores 20 --dag -np | dot -Tps > dag.eps