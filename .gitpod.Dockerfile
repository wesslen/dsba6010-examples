ARG BASE_CONTAINER=rocker/verse:4.0.4
FROM $BASE_CONTAINER

# install r packages
RUN R -e "install.packages('tidyverse', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('brms', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('osfr', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))"
RUN R -e "devtools::install_github('rmcelreath/rethinking')"

# install cmdstanr
RUN mkdir -p /workspace/.cmdstanr
ENV PATH="/workspace/.cmdstanr:${PATH}"
RUN R -e "cmdstanr::install_cmdstan(dir = '/workspace/.cmdstanr', cores = 4)"

# rstudio setup
COPY .gitpod/database.conf /etc/rstudio/database.conf
COPY .gitpod/.Rprofile /usr/local/lib/R/etc/Rprofile.site
# install lib dependencies

EXPOSE 8787