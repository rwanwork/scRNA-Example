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


#####################################################################
##  Process arguments using docopt
#####################################################################

"Usage:  percent-mito.R --input INPUT --output OUTPUT --genome GENOME

Options:
  --input INPUT  Input R object
  --output OUTPUT  Output R object
  --genome GENOME  Genome to be processed
  
.
" -> options

# Retrieve the command-line arguments
opts <- docopt (options)

INPUT_ARG <- opts$input
OUTPUT_ARG <- opts$output
GENOME_ARG <- opts$genome


######################################################################
##  Read in the object
######################################################################

seurat_obj <- readRDS (INPUT_ARG)


######################################################################
##  Calculate the percentage of mitochondrial genes
######################################################################

# Calculate the percentage of mitochondrial genes and store it in percent.mito
#    - Needs to be "^mt-" for mm10
#    - Needs to be "^MT-" for hg38
if (GENOME_ARG == "mm10") {
  PATTERN <- "^mt-"
} else if (GENOME_ARG == "hg38") {
  PATTERN <- "^MT-"
} else {
  stop ("EE\tInvalid genome!")
}

mito.genes <- grep (pattern = PATTERN, x = rownames (x = seurat_obj@data), value = TRUE)
percent.mito <- Matrix::colSums (seurat_obj@raw.data[mito.genes, ]) / Matrix::colSums (seurat_obj@raw.data)

# Store the mitochondrial genes percentage in seurat_obj
seurat_obj <- AddMetaData (object = seurat_obj, metadata = percent.mito, col.name = "percent.mito")


######################################################################
##  Save the object
######################################################################

saveRDS (seurat_obj, file = OUTPUT_ARG)


