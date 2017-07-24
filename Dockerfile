# get the base image, the rocker/verse has R, RStudio and pandoc
FROM rocker/verse:3.4.1

# required
MAINTAINER Martin Hinz <martin.hinz@ufg.uni-kiel.de>

COPY . /mytestpackagerr

# go into the repo directory
RUN . /etc/environment \

  # Install linux depedendencies here
  # e.g. need this for ggforce::geom_sina
  && sudo apt-get update \
  && sudo apt-get install libudunits2-dev -y \

  # build this compendium package
  && R -e "devtools::install('/mytestpackagerr', dep=TRUE)" \

 # render the manuscript into a docx
  && R -e "rmarkdown::render('/mytestpackagerr/analysis/paper/paper.Rmd')"
