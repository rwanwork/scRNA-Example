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

"Usage:  scale-data.R --input INPUT --output OUTPUT

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
##  Scale the data
######################################################################

#  Regress out cell-cell variation according to:
#    - number of detected molecules
#    - mitochondrial gene expression
seurat_obj <- ScaleData (object = seurat_obj, vars.to.regress = c ("nUMI", "percent.mito"))


######################################################################
##  Save the object
######################################################################

saveRDS (seurat_obj, file = OUTPUT_ARG)


