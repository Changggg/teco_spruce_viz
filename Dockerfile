FROM r-base:latest
COPY . /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts
RUN Rscript Rinstall_packages.R
#ENTRYPOINT ["Rscript"]
CMD ["Rscript", "ECOPAD_viz.R"]
