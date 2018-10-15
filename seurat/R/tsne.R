#!/usr/bin/env Rscript
#####################################################################
##
##  Run Non-linear dimensional reduction (tSNE)
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

"Usage:  tsne.R --input INPUT --output OUTPUT

Options:
  --input INPUT  Input R object
  --output OUTPUT  Output R object
  
.
" -> options

# Retrieve the command-line arguments
opts <- docopt (options)

INPUT_ARG <- opts$input
OUTPUT_ARG <- opts$output


######################################################################
##  Read in the object
######################################################################

seurat_obj <- readRDS (INPUT_ARG)


######################################################################
##  Run TSNE
######################################################################

seurat_obj <- RunTSNE (object = seurat_obj, dims.use = 1:10)


######################################################################
##  Save the object
######################################################################

saveRDS (seurat_obj, file = OUTPUT_ARG)


