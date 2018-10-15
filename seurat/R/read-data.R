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

"Usage:  read_data.R --projname PROJECT_NAME --input INPUT --output OUTPUT

Options:
  --projname PROJECT_NAME  Name of the project
  --input INPUT  Path to the input data set
  --output OUTPUT  Output R object

.
" -> options

# Retrieve the command-line arguments
opts <- docopt (options)

PROJNAME_ARG <- opts$projname
INPUT_ARG <- opts$input
OUTPUT_ARG <- opts$output


######################################################################
##  Test values
######################################################################

# DATAPATH_ARG <- "filtered_gene_bc_matrices/mm10/"
# PROJNAME_ARG <- "YB2"
# OUTPREFIX_ARG <- "yb2"

# DATAPATH_ARG <- "filtered_gene_bc_matrices/hg19/"
# PROJNAME_ARG <- "Seurat Tutorial"
# OUTPREFIX_ARG <- "foo"


######################################################################
##  Read in the data and create the seurat object
######################################################################

# Load the PBMC dataset
data <- Read10X (data.dir = INPUT_ARG)

# Initialize the Seurat object with raw data.
#   - Keep all genes expressed in >= MIN_CELLS cells. 
#   - Keep all cells with >= MIN_GENES detected genes
seurat_obj <- CreateSeuratObject (raw.data = data, min.cells = MIN_CELLS, min.genes = MIN_GENES, project = PROJNAME_ARG)


######################################################################
##  Save the object
######################################################################

saveRDS (seurat_obj, file = OUTPUT_ARG)


