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

"Usage:  variable-genes.R --input INPUT --output OUTPUT --vargenes VARGENES

Options:
  --input INPUT  Input R object
  --output OUTPUT  Output R object
  --vargenes VARGENES  Output graph of variable genes
  
.
" -> options

# Retrieve the command-line arguments
opts <- docopt (options)

INPUT_ARG <- opts$input
OUTPUT_ARG <- opts$output
VARIABLE_GENES_ARG <- opts$vargenes


######################################################################
##  Read in the object
######################################################################

seurat_obj <- readRDS (INPUT_ARG)


######################################################################
##  Perform normalization
######################################################################

#  Identify variable genes, while taking variability and average expression into account
#    - Average expression
#    - Dispersion
#  Divide genes into 20 bins according to expression and then calculate
#  the z-score.
postscript (file = VARIABLE_GENES_ARG, onefile=FALSE, width=FIGURE_WIDTH, height=FIGURE_HEIGHT, paper="special", horizontal=FALSE)
seurat_obj <- FindVariableGenes (object = seurat_obj, mean.function = ExpMean, dispersion.function = LogVMR, x.low.cutoff = 0.0125, x.high.cutoff = 3, y.cutoff = 0.5)
dev.off ()

print (length (x = seurat_obj@var.genes))


######################################################################
##  Save the object
######################################################################

saveRDS (seurat_obj, file = OUTPUT_ARG)


