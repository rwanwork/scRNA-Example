#!/usr/bin/env Rscript
#####################################################################
##
##  Normalize the data set
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

"Usage:  print-pca.R --input INPUT --image IMAGE

Options:
  --input INPUT  Input R object
  --image IMAGE  Output graph
  
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
##  Perform normalization
######################################################################

# Examine and visualize the PCA results
PrintPCA (object = seurat_obj, pcs.print = 1:5, genes.print = 5, use.full = FALSE)

#   - Should be done after RunPCA () and FindClusters (), if we want 
#     the clusters in pretty colours
postscript (file = IMAGE_ARG, onefile=FALSE, width=FIGURE_WIDTH, height=FIGURE_HEIGHT, paper="special", horizontal=FALSE)
PCAPlot (object = seurat_obj, dim.1 = 1, dim.2 = 2)
dev.off ()



