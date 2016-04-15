

args = commandArgs(TRUE)
library(ggplot2)
# args[1] is the directory for observation files
# args[2] is the directory for simulation files
# args[2] is output directory of graphs
args1 = "obs_file/SPRUCE_obs.txt"
args2 = "graphoutput/Simu_dailyflux.txt"
args3 = "graphoutput"

tmp <- read.table(args2,sep=",")
len1 = 10000
len2 = nrow(tmp)
tmp <- tmp[len1:len2,c(-20)]
npara = ncol(tmp)
data.reshape = reshape(tmp,idvar="V1",varying=list(2:19),direction="long")

setwd(args3)
png(height=1200, width=1400,pointsize=40, file="histogram.png")
ggplot(data.reshape,aes(V2)) + geom_histogram() + facet_wrap(~ time,scales="free_x")
dev.off()




