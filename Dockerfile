FROM dddlab/base-rstudio:v20200720-d6cbe5a-94fdd01b492f

LABEL maintainer="Patrick Windmiller <windmiller@pstat.ucsb.edu>"

USER $NB_USER

RUN conda install -y r-base && \
    conda install -c conda-forge udunits2 && \
    conda install -c conda-forge imagemagick && \
    conda install -c conda-forge r-rstan && \
    conda install -c conda-forge r-units && \
    conda install -c conda-forge r-sf && \
    conda install -c conda-forge r-foreign

USER root

RUN git clone https://github.com/TheLocehiliosan/yadm.git /usr/local/share/yadm && \
    ln -s /usr/local/share/yadm/yadm /usr/local/bin/yadm

RUN pip install nbgitpuller && \
    jupyter serverextension enable --py nbgitpuller --sys-prefix

RUN pip install jupyter-server-proxy jupyter-rsession-proxy

# ggplot2 extensions
RUN install2.r --error \
    GGally \
    ggridges \
    RColorBrewer \
    scales \
    viridis

# Misc utilities
RUN install2.r --error \
    beepr \
    config \
    doParallel \
    DT \
    foreach \
    formattable \
    glue \
    here \
    Hmisc \
    httr

RUN install2.r --error \
    jsonlite \
    kableExtra \
    logging \
    MASS \
    microbenchmark \
    openxlsx \
    pkgdown \
    rlang

RUN install2.r --error \
    RPushbullet \
    roxygen2 \
    stringr \
    styler \
    testthat \
    usethis  \
    ggridges \
    plotmo

# Caret and some ML packages
RUN install2.r --error \
    # ML framework
    caret \
    car \
    ensembleR \
    # metrics
    MLmetrics \
    pROC \
    ROCR \
    # Models
    Rtsne \
    NbClust

RUN install2.r --error \
    tree \
    maptree \
    arm \
    e1071 \
    elasticnet \
    fitdistrplus \
    gam \  
    gamlss \
    glmnet \
    lme4 \  
    ltm \
    randomForest \
    rpart \
    # Data
    ISLR

RUN conda install -y -c conda-forge r-cairo && \
    install2.r --error imager

RUN installGithub.r \
    gbm-developers/gbm3 \
    bradleyboehmke/harrypotter && \
    install2.r --error rstantools shinystan

# More Bayes stuff
RUN install2.r --error \
    coda \
    loo \
    projpred \
    MCMCpack \
    hflights \
    HDInterval \
    tidytext \
    dendextend

USER $NB_USER
