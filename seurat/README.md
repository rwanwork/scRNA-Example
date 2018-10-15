Seurat
======


Introduction
------------

[Seurat](https://satijalab.org/seurat/) is an R package for analyzing 10x data.  On the developer's homepage, there is an excellent [tutorial](https://satijalab.org/seurat/get_started.html) to help users get started.

This repository contains the ***exact*** same tutorial but written out as a [Snakemake](https://snakemake.readthedocs.io/en/stable/) workflow that runs within a [Miniconda](https://conda.io/miniconda.html) environment.

Note that Seurat is probably best run interactively; but by separating the commands into individual Snakemake steps, it makes it easier to visualize the dependencies between steps.

If there is any ambiguity between the steps mentioned here and the original tutorial, please consult the tutorial.  (But, an e-mail to me to inform me of what I did wrong would be appreciated.)


Requirements
------------

| Software      | Version        | Required? | Web site                            |
| ------------- | -------------- | --------- | ----------------------------------- |
| R             | 3.4.1          | Yes       | https://www.r-project.org/          |
| Snakemake     | 5.2.2          | Yes       | https://snakemake.readthedocs.io/   |
| Miniconda     | 4.5.11         | Yes       | https://conda.io/miniconda.html     |
| Seurat        | 2.3.4          | Yes       | https://satijalab.org/seurat/       |

In the table above, the software versions that were used.  Of course, these are not the minimum versions and earlier versions of the software may work


Running the Example
-------------------

(To be completed)


About this Repository
---------------------

All credit should be given to the developers of Seurat and their excellent on-line tutorial.  The contents of this repository could be written in a day or two because of the quality of their tutorial.  

Currently, I'm at the Hong Kong University of Science and Technology:

     E-mails:  rwan.work@gmail.com 
               OR 
               raymondwan@ust.hk

My homepage is [here](http://www.rwanwork.info/).

If you have any information about bugs, suggestions for the documentation or just have some general comments, feel free to write to either of the above addresses.


Copyright and License
---------------------

    scRNA Examples
    Copyright (C) 2018  Raymond Wan

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
    
Please see the file LICENSE in the main directory for the license.


Raymond Wan
October 15, 2018


