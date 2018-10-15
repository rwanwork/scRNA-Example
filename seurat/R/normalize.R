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

"Usage:  normalize.R --input INPUT --output OUTPUT

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
##  Perform normalization
######################################################################

#  Normalize the data by using a:
#    - log transformation
#    - scale factor of 10,000
seurat_obj <- NormalizeData (object = seurat_obj, normalization.method = "LogNormalize", scale.factor = 1e4)


######################################################################
##  Save the object
######################################################################

saveRDS (seurat_obj, file = OUTPUT_ARG)


