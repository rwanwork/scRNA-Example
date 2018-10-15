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

"Usage:  find-deg-tsne.R --input INPUT --image IMAGE

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

INTERESTING_GENES <- QSC_TABLE_GENES

postscript (file = IMAGE_ARG, onefile=FALSE, width=FIGURE_WIDTH, height=FIGURE_HEIGHT, paper="special", horizontal=FALSE)
VlnPlot (object = seurat_obj, features.plot = INTERESTING_GENES)
dev.off ()



