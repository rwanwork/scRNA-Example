#####################################################################
##
##  Constants
##
#####################################################################

#####################################################################
##  Miscellaneous constants
#####################################################################

MIN_CELLS <- 3
MIN_GENES <- 200

# Additional filter for cells
#   - Set low and high cut-off for gene counts
#   - Set low and high count for mitochondrial percentage
# Use -Inf or Inf if no threshold is to be used
GENE_COUNT_LOW <- 200
GENE_COUNT_HIGH <- 2500
MITO_PERCENT_HIGH <- 0.05
MITO_PERCENT_LOW <- -Inf

FIGURE_WIDTH <- 12
FIGURE_HEIGHT <- 9


#####################################################################
##  Genes to focus on (mm10)
#####################################################################

QSC_TABLE_GENES <- c("Pax7")


#####################################################################
##  Genes to focus on (hg38)
#####################################################################

# c("MS4A1", "GNLY", "CD3E", "CD14", "FCER1A", "FCGR3A", "LYZ", "PPBP", "CD8A")



