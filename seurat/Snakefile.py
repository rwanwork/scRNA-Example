#####################################################################
##  Snakefile
##
##  Raymond Wan (raymondwan@ust.hk)
##  Organizations:
##    - Division of Life Science, 
##      Hong Kong University of Science and Technology
##      Hong Kong
##
##  Copyright (C) 2018, Raymond Wan, All rights reserved.
#####################################################################

##  Configuration file
#configfile: "config.yaml"


##  Define global constraints on wildcards
wildcard_constraints:
  genome = "mm10|hg38"

##  Include additional functions and rules
include: "global-vars.py"


##  Set the shell and the prefix to run before "shell" commands -- activate the dek conda environment
shell.executable ("/bin/bash")
shell.prefix ("source /opt/miniconda3/etc/profile.d/conda.sh; conda activate 10x; ")


########################################
##  Top-level rule
########################################
rule all:
  input:
    "Complete/Sample1_mm10.all"


rule Complete:
  input: 
    input_fn1 = "Objects/{sample}_{genome}/tsne.obj",
    input_fn2 = "Complete/{sample}_{genome}.pca",
    input_fn3 = "Complete/{sample}_{genome}.tsne",
    input_fn4 = "Complete/{sample}_{genome}.deg",
    input_fn5 = "Output/{sample}_{genome}/markers.tsv",
    input_fn6 = "Output/{sample}_{genome}/percent-mito.eps"
  output:
    output_fn = "Complete/{sample}_{genome}.all"
  shell:
    """
    touch {output.output_fn}
    """


########################################
##  Mid-level rules
########################################
rule PCA_Images:
  input: 
    input_fn1 = "Output/{sample}_{genome}/pca.eps",
    input_fn2 = "Output/{sample}_{genome}/pca-genes.eps",
    input_fn3 = "Output/{sample}_{genome}/pca-heatmap.eps"
  output:
    output_fn = "Complete/{sample}_{genome}.pca"
  shell:
    """
    touch {output.output_fn}
    """


rule TSNE_Images:
  input: 
    input_fn1 = "Output/{sample}_{genome}/tsne.eps",
  output:
    output_fn = "Complete/{sample}_{genome}.tsne"
  shell:
    """
    touch {output.output_fn}
    """


rule DEG_Images:
  input: 
    input_fn1 = "Output/{sample}_{genome}/deg-prob.eps",
    input_fn2 = "Output/{sample}_{genome}/deg-raw.eps",
    input_fn3 = "Output/{sample}_{genome}/deg-tsne.eps",
    input_fn4 = "Output/{sample}_{genome}/deg-dots.eps"
  output:
    output_fn = "Complete/{sample}_{genome}.deg"
  shell:
    """
    touch {output.output_fn}
    """


########################################
##  Other rules
########################################
rule Read_Data:
  input: 
    input_fn1 = INPUT_DIR + "/{sample}_count/outs/filtered_gene_bc_matrices/{genome}/"
  output:
    output_fn = "Objects/{sample}_{genome}/read-data.obj"
  params:
    sample = "{sample}"
  shell:
    """
    R/read-data.R --projname {params.sample} --input {input.input_fn1} --output {output.output_fn}
    """

    
rule Percent_Mito:
  input: 
    input_fn1 = "Objects/{sample}_{genome}/read-data.obj"
  output:
    output_fn1 = "Objects/{sample}_{genome}/percent-mito.obj"
  params:
    genome = "{genome}"
  shell:
    """
    R/percent-mito.R --input {input.input_fn1} --output {output.output_fn1} --genome {params.genome}
    """


rule Print_Percent_Mito:
  input: 
    input_fn1 = "Objects/{sample}_{genome}/percent-mito.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/percent-mito.eps"
  shell:
    """
    R/print-percent-mito.R --input {input.input_fn1} --image {output.output_fn1}
    """


rule Percent_Mito_Filter:
  input: 
    input_fn1 = "Objects/{sample}_{genome}/percent-mito.obj"
  output:
    output_fn1 = "Objects/{sample}_{genome}/percent-mito-filter.obj",
    output_fn2 = "Output/{sample}_{genome}/percent-mito-filter.eps"
  shell:
    """
    R/print-percent-mito-filter.R --input {input.input_fn1} --output {output.output_fn1} --image {output.output_fn2}
    """


rule Normalize:
  input:
    input_fn1 = "Objects/{sample}_{genome}/percent-mito-filter.obj",
  output:
    output_fn1 = "Objects/{sample}_{genome}/normalize.obj"
  shell:
    """
    R/normalize.R --input {input.input_fn1} --output {output.output_fn1}
    """
      
    
rule Variable_Genes:
  input:
    input_fn1 = "Objects/{sample}_{genome}/normalize.obj",
  output:
    output_fn1 = "Objects/{sample}_{genome}/variable-data.obj",
    output_fn2 = "Output/{sample}_{genome}/variable-genes.eps"
  shell:
    """
    R/variable-genes.R --input {input.input_fn1} --output {output.output_fn1} --vargenes {output.output_fn2}
    """


rule Scale_Data:
  input:
    input_fn1 = "Objects/{sample}_{genome}/variable-data.obj",
  output:
    output_fn1 = "Objects/{sample}_{genome}/scale-data.obj"
  shell:
    """
    R/scale-data.R --input {input.input_fn1} --output {output.output_fn1}
    """


rule PCA:
  input:
    input_fn1 = "Objects/{sample}_{genome}/variable-data.obj",
    input_fn2 = "Objects/{sample}_{genome}/scale-data.obj"
  output:
    output_fn1 = "Objects/{sample}_{genome}/pca.obj"
  shell:
    """
    R/pca.R --input {input.input_fn2} --output {output.output_fn1}
    """


rule Find_Clusters:
  input:
    input_fn1 = "Objects/{sample}_{genome}/pca.obj"
  output:
    output_fn1 = "Objects/{sample}_{genome}/find-clusters.obj"
  shell:
    """
    R/find-clusters.R --input {input.input_fn1} --output {output.output_fn1}
    """


rule Print_PCA:
  input:
    input_fn1 = "Objects/{sample}_{genome}/find-clusters.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/pca.eps",
  shell:
    """
    R/print-pca.R --input {input.input_fn1} --image {output.output_fn1}
    """


rule Print_PCA_Genes:
  input:
    input_fn1 = "Objects/{sample}_{genome}/find-clusters.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/pca-genes.eps",
  shell:
    """
    R/print-pca-genes.R --input {input.input_fn1} --image {output.output_fn1}
    """


rule Print_PCA_Heatmap:
  input:
    input_fn1 = "Objects/{sample}_{genome}/find-clusters.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/pca-heatmap.eps"
  shell:
    """
    R/print-pca-heatmap.R --input {input.input_fn1} --image {output.output_fn1}
    """


rule TSNE:
  input:
    input_fn1 = "Objects/{sample}_{genome}/find-clusters.obj"
  output:
    output_fn1 = "Objects/{sample}_{genome}/tsne.obj"
  shell:
    """
    R/tsne.R --input {input.input_fn1} --output {output.output_fn1}
    """


rule Print_TSNE:
  input:
    input_fn1 = "Objects/{sample}_{genome}/tsne.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/tsne.eps"
  shell:
    """
    R/print-tsne.R --input {input.input_fn1} --output {output.output_fn1}
    """


rule Find_Markers:
  input:
    input_fn1 = "Objects/{sample}_{genome}/tsne.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/markers.tsv"
  shell:
    """
    R/find-markers.R --input {input.input_fn1} --table {output.output_fn1}
    """


rule Find_DEG_Prob:
  input:
    input_fn1 = "Objects/{sample}_{genome}/find-clusters.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/deg-prob.eps"
  shell:
    """
    R/find-deg-prob.R --input {input.input_fn1} --image {output.output_fn1}
    """


rule Find_DEG_Raw:
  input:
    input_fn1 = "Objects/{sample}_{genome}/find-clusters.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/deg-raw.eps"
  shell:
    """
    R/find-deg-raw.R --input {input.input_fn1} --image {output.output_fn1}
    """


rule Find_DEG_TSNE:
  input:
    input_fn1 = "Objects/{sample}_{genome}/tsne.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/deg-tsne.eps"
  shell:
    """
    R/find-deg-tsne.R --input {input.input_fn1} --image {output.output_fn1}
    """


rule Find_DEG_Dots:
  input:
    input_fn1 = "Objects/{sample}_{genome}/find-clusters.obj"
  output:
    output_fn1 = "Output/{sample}_{genome}/deg-dots.eps"
  shell:
    """
    R/find-deg-dots.R --input {input.input_fn1} --image {output.output_fn1}
    """


