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

"Usage:  print-pca-heatmap.R --input INPUT --image IMAGE

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

postscript (file = IMAGE_ARG, onefile=FALSE, width=FIGURE_WIDTH, height=FIGURE_HEIGHT, paper="special", horizontal=FALSE)
PCHeatmap (object = seurat_obj, pc.use = 1, cells.use = 500, do.balanced = TRUE, label.columns = FALSE)
dev.off ()

