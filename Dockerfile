FROM r-base:latest
COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts
CMD ["Rscript", "ECOPAD_viz.R"]
