#!/usr/bin/env Rscript
#####################################################################
##
##  Read the data in
##
#####################################################################

#####################################################################
##  Read in libraries and modules
#####################################################################

library (Seurat)
library (dplyr)
library (docopt)  #  See:  https://github.com/docopt/docopt.R

source ("R/modules/constants.R")


#####################################################################
##  Process arguments using docopt
#####################################################################

"Usage:  print-percent-mito-filter.R --input INPUT --output OUTPUT --image IMAGE

Options:
  --input INPUT  Input R object
  --output OUTPUT  Output R object
  --image IMAGE  Output eps file
  
.
" -> options

# Retrieve the command-line arguments
opts <- docopt (options)

INPUT_ARG <- opts$input
OUTPUT_ARG <- opts$output
IMAGE_ARG <- opts$image


######################################################################
##  Read in the object
######################################################################

seurat_obj <- readRDS (INPUT_ARG)


######################################################################
##  Calculate the percentage of mitochondrial genes
######################################################################

# We filter out cells based on lower and upper bound on:
#   - # of gene counts
#   - percentage of mitochondrial genes
seurat_obj_tmp <- FilterCells (object = seurat_obj, subset.names = c("nGene", "percent.mito"), low.thresholds = c (GENE_COUNT_LOW, MITO_PERCENT_LOW), high.thresholds = c (GENE_COUNT_HIGH, MITO_PERCENT_HIGH))

# Show the effect from the filter in a 2 x 2 grid
postscript (file = IMAGE_ARG, onefile=FALSE, width=FIGURE_WIDTH, height=FIGURE_HEIGHT, paper="special", horizontal=FALSE)
par (mfrow = c(2, 2))
GenePlot (object = seurat_obj, gene1 = "nUMI", gene2 = "percent.mito")
GenePlot (object = seurat_obj, gene1 = "nUMI", gene2 = "nGene")
GenePlot (object = seurat_obj_tmp, gene1 = "nUMI", gene2 = "percent.mito")
GenePlot (object = seurat_obj_tmp, gene1 = "nUMI", gene2 = "nGene")
dev.off ()
par (mfrow = c(1,1))  #  Reset mfrow
seurat_obj <- seurat_obj_tmp


######################################################################
##  Save the object
######################################################################

saveRDS (seurat_obj, file = OUTPUT_ARG)


