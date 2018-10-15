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

"Usage:  find-clusters.R --input INPUT --output OUTPUT

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

seurat_obj <- FindClusters (object = seurat_obj, reduction.type = "pca", dims.use = 1:10, resolution = 0.6, print.output = 0, save.SNN = TRUE)

PrintFindClustersParams (object = seurat_obj)


######################################################################
##  Save the object
######################################################################

saveRDS (seurat_obj, file = OUTPUT_ARG)


