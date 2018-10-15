#!/usr/bin/env Rscript
#####################################################################
##
##  Run PCA
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

"Usage:  pca.R --input INPUT --output OUTPUT

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
##  Apply PCA
######################################################################

# Print at most 5 genes for each principal component;
#   - Must be run after FindVariableGenes () and ScaleData ()
seurat_obj <- RunPCA (object = seurat_obj, pc.genes = seurat_obj@var.genes, do.print = TRUE, pcs.print = 1:5, genes.print = 5)


######################################################################
##  Save the object
######################################################################

saveRDS (seurat_obj, file = OUTPUT_ARG)


