## Use a tag instead of "latest" for reproducibility
FROM rocker/binder:latest

## Declares build arguments
ARG NB_USER
ARG NB_UID

## Copies your repo files into the Docker Container
USER root
COPY . ${HOME}
## Enable this to copy files from the binder subdirectory
## to the home, overriding any existing files.
## Useful to create a setup on binder that is different from a
## clone of your repository
## COPY binder ${HOME}
RUN chown -R ${NB_USER} ${HOME}

## Become normal user again
USER ${NB_USER}

## add in Renv
#ENV RENV_VERSION 0.14.0
#RUN R -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'))"
#RUN R -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

#WORKDIR /project
#COPY renv.lock renv.lock
#RUN R -e "install.packages('renv')"
#RUN R -e "renv::restore()"

## Run an install.R script, if it exists.
RUN if [ -f install.R ]; then R --quiet -f install.R; fi