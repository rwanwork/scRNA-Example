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
source ("R/modules/io.R")


#####################################################################
##  Process arguments using docopt
#####################################################################

"Usage:  print-percent-mito.R --input INPUT --image IMAGE

Options:
  --input INPUT  Input R object
  --image IMAGE  Output image
  
.
" -> options

# Retrieve the command-line arguments
opts <- docopt (options)

INPUT_ARG <- opts$input
IMAGE_ARG <- opts$image


######################################################################
##  Read in the object
######################################################################

seurat_obj <- readRDS (INPUT_ARG)


######################################################################
##  Calculate the percentage of mitochondrial genes
######################################################################

# Print a violin plot of the percentage of mitochondrial genes
postscript (file = IMAGE_ARG, onefile=FALSE, width=FIGURE_WIDTH, height=FIGURE_HEIGHT, paper="special", horizontal=FALSE)
VlnPlot (object = seurat_obj, features.plot = c("nGene", "nUMI", "percent.mito"), nCol = 3)
dev.off ()


