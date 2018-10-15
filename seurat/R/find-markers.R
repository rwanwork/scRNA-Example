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
source ("R/modules/io.R")


#####################################################################
##  Process arguments using docopt
#####################################################################

"Usage:  find-markers.R --input INPUT --table TABLE

Options:
  --input INPUT  Input R object
  --table TABLE  Output table
  
.
" -> options

# Retrieve the command-line arguments
opts <- docopt (options)

INPUT_ARG <- opts$input
TABLE_ARG <- opts$table


######################################################################
##  Read in the object
######################################################################

seurat_obj <- readRDS (INPUT_ARG)


######################################################################
##  Perform normalization
######################################################################

# find markers for every cluster compared to all remaining cells
#    - Add "only.pos = TRUE" to report only the positive ones
all.markers <- FindAllMarkers (object = seurat_obj, min.pct = 0.25, thresh.use = 0.25)
all.markers.df <- data.frame (all.markers %>% group_by (cluster) %>% top_n (10, avg_logFC))

writeTable (all.markers.df, TABLE_ARG)



